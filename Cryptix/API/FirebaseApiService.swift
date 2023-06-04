//
//  FirebaseApiService.swift
//  Cryptix
//
//  Created by fe on 28.05.2023.
//

import Firebase
import Foundation

class FirebaseApiService {
    // MARK: - Authentication methods

    /// Login with email
    func loginWithEmail(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

    /// Register user
    func registerUser(with user: UserModel, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        if user.email != nil && user.password != nil {
            Auth.auth().createUser(withEmail: user.email!, password: user.password!) { result, error in
                if let error = error {
                    completion(nil, error)
                }

                guard let uid = result?.user.uid else {
                    completion(nil, error)
                    return
                }

                let data: [String: Any] = ["email": user.email!, "password": user.password!, "name": user.name!, "uid": uid]
                Firestore.firestore().collection("users").document(uid).setData(data) { error in
                    completion(nil, error)
                }
            }
        }
    }

    /// Get user info
    func getUserInfo() async throws -> UserModel? {
        guard let currentUser = Auth.auth().currentUser else {
            throw CustomError.userNotFount(message: "User not found")
        }

        let uid = currentUser.uid
        let userRef = Firestore.firestore().collection("users").document(uid)

        do {
            let document = try await userRef.getDocument()
            let data = document.data()

            guard let email = data?["email"] as? String else {
                throw CustomError.fieldCouldNotFound(message: "No email field")
            }
            guard let name = data?["name"] as? String else {
                throw CustomError.fieldCouldNotFound(message: "No name field")
            }
            let userModel = UserModel(name: name, email: email)

            return userModel
        } catch {
            throw CustomError.documentDoesNotExist(message: "Document does not exist")
        }
    }

    /// Sign out
    func signOut() async throws {
        do {
            try await Auth.auth().signOut()
        } catch {
            throw CustomError.cantSignOut(message: error.localizedDescription)
        }
    }

    // MARK: - Firebase get, add,delete and edit methods

    /// Get crypto address
    func getCryptoAddresses() async throws -> [CryptoAddressModel?] {
        var addressList: [CryptoAddressModel?] = []
        guard let user = Auth.auth().currentUser else {
            throw CustomError.userNotFount(message: "User could not found")
        }

        let uid = user.uid

        let documentRef = Firestore.firestore().collection("users").document(uid).collection("addresses")

        do {
            let addresses = try await documentRef.order(by: "dateCreated").getDocuments()

            for address in addresses.documents {
                let data = address.data()

                guard let name = data["name"], let exchange = data["exchange"], let cryptoAddress = data["cryptoAddress"], let cryptoImage = data["cryptoImage"] else {
                    throw CustomError.documentDoesNotExist(message: "One of the fields does not exist")
                }
                addressList.append(CryptoAddressModel(name: name as? String, exchange: exchange as? String, cryptoAddress: cryptoAddress as? String, cryptoImage: cryptoImage as? String))
            }

            return addressList

        } catch {
            throw CustomError.documentDoesNotExist(message: error.localizedDescription)
        }
    }

    /// Add new crypto address
    func addCryptoAddress(with cryptoAdressModel: CryptoAddressModel) async throws {
        guard let currentUser = Auth.auth().currentUser else {
            throw CustomError.userNotFount(message: "User could not found")
        }

        let uid = currentUser.uid

        let userCollection = Firestore.firestore().collection("users")

        // Generate a new document ID
        let newDocumentRef = userCollection.document()

        // Create a data dictionary with the fields you want to store in the new document
        let newData: [String: Any] = [
            "name": cryptoAdressModel.name!,
            "exchange": cryptoAdressModel.exchange!,
            "cryptoAddress": cryptoAdressModel.cryptoAddress!,
            "dateCreated": Date().timeIntervalSince1970,
            "cryptoImage": cryptoAdressModel.cryptoImage!
        ]

        let userDocument = userCollection.document(uid)

        do {
            try await userDocument.collection("addresses").document(newDocumentRef.documentID).setData(newData)
        } catch {
            throw CustomError.cantSetNewCryptoAdress(message: error.localizedDescription)
        }
    }

    // MARK: - Crypto actions api services

    func deleteCryptoAddress(with cryptoAdressModel: CryptoAddressModel) async throws -> [CryptoAddressModel?] {
        guard let currentUser = Auth.auth().currentUser else {
            throw CustomError.userNotFount(message: "User could not found")
        }

        let uid = currentUser.uid

        let collection = Firestore.firestore().collection("users").document(uid).collection("addresses")

        do {
            let addresses = try await collection.getDocuments()

            for address in addresses.documents {
                let data = address.data()

                guard let cryptoAddress = data["cryptoAddress"] as? String else {
                    throw CustomError.documentDoesNotExist(message: "One of the fields does not exist")
                }

                if cryptoAddress == cryptoAdressModel.cryptoAddress {
                    do {
                        try await address.reference.delete()
                        do {
                            let newAddressList = try await getCryptoAddresses()
                            return newAddressList
                        } catch {
                            throw CustomError.documentDoesNotExist(message: "Something went wrong")
                        }
                    } catch {
                        throw CustomError.documentDoesNotExist(message: "Document could not found.")
                    }
                }
            }
        } catch {
            throw CustomError.documentDoesNotExist(message: error.localizedDescription)
        }

        return []
    }

    /// Edit crypto address
    func editCryptoAddress(editedCryptoModel: CryptoAddressModel, currentCryptoModel: CryptoAddressModel) async throws -> [CryptoAddressModel?] {
        guard let currentUser = Auth.auth().currentUser else {
            throw CustomError.userNotFount(message: "User could not found")
        }

        let uid = currentUser.uid

        let collection = Firestore.firestore().collection("users").document(uid).collection("addresses")

        do {
            let addresses = try await collection.getDocuments()

            for address in addresses.documents {
                let data = address.data()

                guard let cryptoAddress = data["cryptoAddress"] as? String else {
                    throw CustomError.documentDoesNotExist(message: "One of the fields does not exist")
                }

                if cryptoAddress == currentCryptoModel.cryptoAddress {
                    do {
                        try await address.reference.setData(["name": editedCryptoModel.name! as String, "exchange": editedCryptoModel.exchange! as String, "cryptoAddress": editedCryptoModel.cryptoAddress! as String], merge: true)
                        do {
                            let newAddressList = try await getCryptoAddresses()
                            return newAddressList
                        } catch {
                            throw CustomError.documentDoesNotExist(message: "Something went wrong")
                        }
                    } catch {
                        throw CustomError.documentDoesNotExist(message: "Document could not found.")
                    }
                }
            }
        } catch {
            throw CustomError.documentDoesNotExist(message: error.localizedDescription)
        }

        return []
    }
}

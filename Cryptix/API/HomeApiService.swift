//
//  HomeApiService.swift
//  Cryptix
//
//  Created by fe on 24.05.2023.
//

import Firebase
import Foundation

class HomeApiService {
    func getCryptoAddresses() async throws -> [CryptoAddressModel?] {
        var addressList: [CryptoAddressModel?] = []
        guard let user = Auth.auth().currentUser else {
            throw CustomError.userNotFount(message: "User could not found")
        }

        let uid = user.uid

        let documentRef = Firestore.firestore().collection("users").document(uid).collection("addresses")

        do {
            let addresses = try await documentRef.getDocuments()

            for address in addresses.documents {
                let data = address.data()

                guard let name = data["name"], let exchange = data["exchange"], let cryptoAddress = data["cryptoAddress"] else {
                    throw CustomError.documentDoesNotExist(message: "One of the fields does not exist")
                }
                addressList.append(CryptoAddressModel(name: name as? String, exchange: exchange as? String, cryptoAddress: cryptoAddress as? String))
            }

            return addressList

        } catch {
            throw CustomError.documentDoesNotExist(message: error.localizedDescription)
        }
    }
}

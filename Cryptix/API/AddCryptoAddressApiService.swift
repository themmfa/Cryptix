//
//  AddCryptoAddressApiService.swift
//  Cryptix
//
//  Created by fe on 23.05.2023.
//

import Firebase
import Foundation

class AddCryptoAddressApiService {
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
            "dateCreated": Date().timeIntervalSince1970
        ]
        
        let userDocument = userCollection.document(uid)
        
        do {
            try await userDocument.collection("addresses").document(newDocumentRef.documentID).setData(newData)
        } catch {
            throw CustomError.cantSetNewCryptoAdress(message: error.localizedDescription)
        }
    }
}

//
//  ProfileApiService.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 23.05.2023.
//




import Foundation
import Firebase


class ProfileApiService{
    
    @MainActor
    func getUserInfo() async throws -> UserModel?{
        guard let currentUser = Auth.auth().currentUser else {
            throw CustomError.userNotFount(message: "User not found")
        }
        
        let uid = currentUser.uid
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        do{
            let document = try await userRef.getDocument()
            let data = document.data()
            
            guard let email = data!["email"] as? String else{
                throw CustomError.fieldCouldNotFound(message: "No email field")
            }
            guard let name = data!["name"] as? String else{
                throw CustomError.fieldCouldNotFound(message: "No name field")
            }
            let userModel = UserModel(name: name,email: email)
            
            return userModel
        }catch{
            throw CustomError.documentDoesNotExist(message: "Document does not exist")
        }
    }
    
    

    func signOut() async throws {
       do {
           try await Auth.auth().signOut()
       } catch {
           throw CustomError.cantSignOut(message: error.localizedDescription)
       }
    }
}

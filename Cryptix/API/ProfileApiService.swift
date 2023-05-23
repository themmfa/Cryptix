//
//  ProfileApiService.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 23.05.2023.
//


enum CustomError:Error{
    case userNotFount(message:String)
    case documentDoesNotExist(message:String)
    case fieldCouldNotFound(message:String)
}

import Foundation
import Firebase


class ProfileApiService{
    
    
    
    func getUserInfo(completion: @escaping (UserModel?, Error?) -> Void){
        
        guard let currentUser = Auth.auth().currentUser else {
            completion(nil,CustomError.userNotFount(message: "User could not found"))
            return
        }
        
        let uid = currentUser.uid
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        userRef.getDocument { document, error in
            if let document = document,document.exists {
                let data = document.data()
                guard let email = data!["email"] as? String else{
                    completion(nil,CustomError.documentDoesNotExist(message: "No name field"))
                    return
                }
                guard let name = data!["name"] as? String else{
                    completion(nil,CustomError.documentDoesNotExist(message: "No name field"))
                    return
                }
                let userModel = UserModel(name: name,email: email)
                completion(userModel,nil)
            }
            else{
                completion(nil,CustomError.documentDoesNotExist(message: error!.localizedDescription))
            }
        }
    }
}

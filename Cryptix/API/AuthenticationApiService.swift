//
//  AuthenticationApiService.swift
//  Cryptix
//
//  Created by fe on 22.05.2023.
//

import Firebase
import FirebaseFirestore
import Foundation

protocol AuthService {
    func loginWithEmail(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void)
    func registerUser(with user: UserModel, completion: @escaping (AuthDataResult?, Error?) -> Void)
}

class AuthenticationApiService: AuthService {
    func loginWithEmail(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

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
}

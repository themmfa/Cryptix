//
//  UserModel.swift
//  Cryptix
//
//  Created by fe on 22.05.2023.
//

import Foundation

class UserModel {
    var name: String?
    var email: String?
    var password: String?

    init(name: String? = nil, email: String? = nil, password: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
    }
}

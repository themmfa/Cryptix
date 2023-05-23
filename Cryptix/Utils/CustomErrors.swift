//
//  CustomErrors.swift
//  Cryptix
//
//  Created by fe on 23.05.2023.
//

import Foundation

enum CustomError: Error {
    case userNotFount(message: String)
    case documentDoesNotExist(message: String)
    case fieldCouldNotFound(message: String)
    case cantSignOut(message: String)
    case cantSetNewCryptoAdress(message: String)
}

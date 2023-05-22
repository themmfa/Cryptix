//
//  LoginViewModel.swift
//  Cryptix
//
//  Created by fe on 22.05.2023.
//

import UIKit

protocol AuthenticationViewModel {
    var email: String? { get }
    var password: String? { get }
    var name: String? { get }
}

class LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var name: String?

    var isFormValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }

    var loginButtonColor: UIColor {
        return isFormValid ? .black : .gray
    }

    var loginButtonEnabled: Bool {
        return isFormValid
    }
}

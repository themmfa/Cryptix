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

    func loginUser(_ view: UIViewController, navigationController: UINavigationController) {
        let activityIndicatorController = CustomActivityIndicator()
        activityIndicatorController.startAnimating(in: view)

        AuthenticationApiService().loginWithEmail(email: email!, password: password!) { _, error in
            if let error = error {
                activityIndicatorController.stopAnimating()
                CustomAlert.showAlert(title: "Error!", message: error.localizedDescription, viewController: view) { _ in
                }
            }
            activityIndicatorController.stopAnimating()
            CustomAlert.showAlert(title: "Success!", message: "You successfully logged in!", viewController: view) { _ in
                navigationController.pushViewController(HomeViewController(), animated: true)
            }
        }
    }
}

class RegisterViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var name: String?

    var isFormValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && name?.isEmpty == false
    }

    var loginButtonColor: UIColor {
        return isFormValid ? .black : .gray
    }

    var loginButtonEnabled: Bool {
        return isFormValid
    }

    func registerUser(_ view: UIViewController, navigationController: UINavigationController) {
        let activityIndicatorController = CustomActivityIndicator()
        activityIndicatorController.startAnimating(in: view)

        let user = UserModel(name: name, email: email, password: password)
        AuthenticationApiService().registerUser(with: user, completion: { _, error in
            if let error = error {
                activityIndicatorController.stopAnimating()
                CustomAlert.showAlert(title: "Error", message: error.localizedDescription, viewController: view) { _ in
                }
            }
            activityIndicatorController.stopAnimating()
            CustomAlert.showAlert(title: "Success!", message: "User registered successfully!", viewController: view) { _ in
                navigationController.pushViewController(HomeViewController(), animated: true)
            }

        })
    }
}

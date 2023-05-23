//
//  AddCryptoAddressViewModel.swift
//  Cryptix
//
//  Created by fe on 23.05.2023.
//

import UIKit

class AddCryptoAddressViewModel {
    private let addCryptoAddressApiService = AddCryptoAddressApiService()

    var name: String?
    var exchange: String?
    var cryptoAddress: String?

    var isFormValid: Bool {
        return name?.isEmpty == false && exchange?.isEmpty == false && cryptoAddress?.isEmpty == false
    }

    var addCryptoButtonColor: UIColor {
        return isFormValid ? .black : .gray
    }

    var addCryptoButtonEnabled: Bool {
        return isFormValid
    }

    func addCryptoAddress(in view: UIViewController, with navigationController: UINavigationController) {
        let activityIndicatorController = CustomActivityIndicator()
        activityIndicatorController.startAnimating(in: view)

        Task {
            do {
                try await addCryptoAddressApiService.addCryptoAddress(with: CryptoAddressModel(name: name, exchange: exchange, cryptoAddress: cryptoAddress))
                DispatchQueue.main.async {
                    activityIndicatorController.stopAnimating()
                    CustomAlert.showAlert(title: "Success", message: "Crypto address successfully added.", viewController: view) { _ in
                        navigationController.popViewController(animated: true)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    activityIndicatorController.stopAnimating()
                    CustomAlert.showAlert(title: "Success", message: "Crypto address successfully added.", viewController: view) { _ in }
                }
            }
        }
    }
}

//
//  HomeViewModel.swift
//  Cryptix
//
//  Created by fe on 24.05.2023.
//

import UIKit

class HomeViewModel {
    var addressList: [CryptoAddressModel?] = []
    var user: UserModel?

    var name: String?
    var exchange: String?
    var cryptoAddress: String?

    private var firebaseApiService = FirebaseApiService()

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
                try await firebaseApiService.addCryptoAddress(with: CryptoAddressModel(name: name, exchange: exchange, cryptoAddress: cryptoAddress))
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

    func deleteAddress(_ cryptoModel: CryptoAddressModel, view: UIViewController) {
        let activityIndicatorController = CustomActivityIndicator()
        activityIndicatorController.startAnimating(in: view)

        Task {
            do {
                let cryptoList = try await firebaseApiService.deleteCryptoAddress(with: cryptoModel)
                DispatchQueue.main.async { [weak self] in
                    activityIndicatorController.stopAnimating()
                    CustomAlert.showAlert(title: "Success", message: "Crypto address deleted successfully!", viewController: view) { _ in }
                    self?.addressList = cryptoList
                    NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
                }
            } catch {
                DispatchQueue.main.async {
                    activityIndicatorController.stopAnimating()
                    CustomAlert.showAlert(title: "Error", message: error.localizedDescription, viewController: view) { _ in }
                }
            }
        }
    }

    func getCryptoAddresses(in view: UIViewController, layout: @escaping () -> Void, collectionView: UICollectionView) {
        let activityIndicatorController = CustomActivityIndicator()
        activityIndicatorController.startAnimating(in: view)

        Task {
            do {
                addressList = try await firebaseApiService.getCryptoAddresses()
                DispatchQueue.main.async {
                    activityIndicatorController.stopAnimating()
                    layout()
                    NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
                }

            } catch {
                DispatchQueue.main.async {
                    activityIndicatorController.stopAnimating()
                    CustomAlert.showAlert(title: "Error", message: error.localizedDescription, viewController: view) { _ in }
                }
            }
        }
    }

    func getUserInfo(in view: UIViewController) async {
        let activityIndicatorController = await CustomActivityIndicator()
        await activityIndicatorController.startAnimating(in: view)

        do {
            user = try await firebaseApiService.getUserInfo()
            await activityIndicatorController.stopAnimating()
        } catch {
            await activityIndicatorController.stopAnimating()
            CustomAlert.showAlert(title: "Error", message: error.localizedDescription, viewController: view) { _ in }
        }
    }

    func signout(in view: UIViewController, with navigationController: UINavigationController) {
        let activityIndicatorController = CustomActivityIndicator()
        activityIndicatorController.startAnimating(in: view)

        Task {
            do {
                try await self.firebaseApiService.signOut()
                await activityIndicatorController.stopAnimating()
                await navigationController.setViewControllers([LoginViewController()], animated: true)
            } catch {
                await activityIndicatorController.stopAnimating()
                CustomAlert.showAlert(title: "Error", message: error.localizedDescription, viewController: view) { _ in }
            }
        }
    }
}

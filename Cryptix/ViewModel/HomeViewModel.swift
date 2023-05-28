//
//  HomeViewModel.swift
//  Cryptix
//
//  Created by fe on 24.05.2023.
//

import UIKit

class HomeViewModel {
    var addressList: [CryptoAddressModel?] = []

    private var firebaseApiService = FirebaseApiService()

    func getCryptoAddresses(in view: UIViewController, layout: @escaping () -> Void, collectionView: UICollectionView) {
        let activityIndicatorController = CustomActivityIndicator()
        activityIndicatorController.startAnimating(in: view)

        Task {
            do {
                addressList = try await firebaseApiService.getCryptoAddresses()
                DispatchQueue.main.async {
                    activityIndicatorController.stopAnimating()
                    layout()
                    collectionView.reloadData()
                }

            } catch {
                DispatchQueue.main.async {
                    activityIndicatorController.stopAnimating()
                    CustomAlert.showAlert(title: "Error", message: error.localizedDescription, viewController: view) { _ in }
                }
            }
        }
    }
}

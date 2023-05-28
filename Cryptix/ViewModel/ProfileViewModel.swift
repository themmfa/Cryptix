//
//  ProfileViewModel.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 23.05.2023.
//

import UIKit

class ProfileViewModel {
    let firebaseApiService = FirebaseApiService()
    
    var user: UserModel?
    
    func getUserInfo(in view: UIViewController) async {
        let activityIndicatorController = await CustomActivityIndicator()
        await activityIndicatorController.startAnimating(in: view)
            
        do {
            self.user = try await self.firebaseApiService.getUserInfo()
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

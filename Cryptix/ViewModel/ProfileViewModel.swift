//
//  ProfileViewModel.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 23.05.2023.
//

import UIKit


class ProfileViewModel{
    
    let profileApiService = ProfileApiService()
    
    var user: UserModel?
    
    func getUserInfo(in view: UIViewController){
        let activityIndicatorController = CustomActivityIndicator()
        activityIndicatorController.startAnimating(in: view)
        profileApiService.getUserInfo {[self] userModel, error in
            if let error = error {
                activityIndicatorController.stopAnimating()
                CustomAlert.showAlert(title: "Error!", message: error.localizedDescription, viewController: view) { _ in
                }
            }
            
            activityIndicatorController.stopAnimating()
            user = userModel
        }
    }
}

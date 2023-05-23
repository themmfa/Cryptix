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
    
    func getUserInfo(in view: UIViewController) async {
        let activityIndicatorController = await CustomActivityIndicator()
        await activityIndicatorController.startAnimating(in: view)
            
        do{
            self.user = try await self.profileApiService.getUserInfo()
            await activityIndicatorController.stopAnimating()
        }catch{
            await activityIndicatorController.stopAnimating()
            CustomAlert.showAlert(title: "Error", message: error.localizedDescription, viewController: view) { _ in }
        }
        }
    
    
    func signout(in view: UIViewController){
        let activityIndicatorController = CustomActivityIndicator()
        activityIndicatorController.startAnimating(in: view)
        
        Task{
            do{
                try await self.profileApiService.signOut()
                await activityIndicatorController.stopAnimating()
            }catch{
                await activityIndicatorController.stopAnimating()
                CustomAlert.showAlert(title: "Error", message: error.localizedDescription, viewController: view) { _ in }
            }
        }
    }
    
}


    



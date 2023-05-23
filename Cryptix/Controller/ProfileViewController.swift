//
//  ProfileViewController.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 23.05.2023.
//

import UIKit


class ProfileViewController: UIViewController{
    
    let profileViewModel = ProfileViewModel()
    
    private var logo: UIImageView = {
        var logo = UIImageView(image: UIImage(named: "cryptix"))
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    private lazy var emailField: UITextField = {
       var emailField = CustomTextfield(placeholder: "")
        emailField.text = profileViewModel.user?.email
        emailField.isUserInteractionEnabled = false
       return emailField
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        profileViewModel.getUserInfo(in:self)
        layout()
    }
}

extension ProfileViewController{
    private func layout(){
        
        // MARK: - Logo layout
        
        view.addSubview(logo)
        logo.centerX(inView: view)
        logo.setDimensions(height: 200, width: 350)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        
        // MARK: - Profile view
        view.addSubview(emailField)
        emailField.centerX(inView: view)
        emailField.anchor(top: logo.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor, paddingTop: 24,paddingLeft: 24,paddingRight: 24)
    }
}

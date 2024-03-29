//
//  ProfileViewController.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 23.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    let homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var logo: UIImageView = {
        var logo = UIImageView(image: UIImage(named: "cryptix"))
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    lazy var emailField: UITextField = {
        var emailField = CustomTextfield(placeholder: "")
        emailField.isUserInteractionEnabled = false
        return emailField
    }()
    
    lazy var nameField: UITextField = {
        var nameField = CustomTextfield(placeholder: "")
        nameField.isUserInteractionEnabled = false
        return nameField
    }()
    
    private var signOutButton: UIButton = {
        var signOutButton = CustomButton(title: "Sign Out")
        signOutButton.backgroundColor = .black
        return signOutButton
    }()
    
    @objc func signOut() {
        homeViewModel.signout()
    }
    
    lazy var activityIndicatorController = CustomActivityIndicator()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        activityIndicatorController.startAnimating(in: self)
        homeViewModel.getUserInfo()
        setupNavBar()
        layout()
    }
}

extension ProfileViewController {
    /// Nav bar setup
    func setupNavBar() {
        navigationController?.setupNavAppearence()
    }
    
    private func layout() {
        // MARK: - Logo layout
        
        view.addSubview(logo)
        logo.centerX(inView: view)
        logo.setDimensions(height: 200, width: 350)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        
        // MARK: - Profile view

        view.addSubview(emailField)
        emailField.centerX(inView: view)
        emailField.anchor(top: logo.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingRight: 24)
        
        view.addSubview(nameField)
        nameField.centerX(inView: view)
        nameField.anchor(top: emailField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingRight: 24)
        
        view.addSubview(signOutButton)
        signOutButton.centerX(inView: view)
        signOutButton.anchor(top: nameField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingRight: 24)
    }
}

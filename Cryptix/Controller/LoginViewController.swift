//
//  ViewController.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 22.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    private var logo:UIImageView = {
       var logo = UIImageView(image: UIImage(named: "cryptix"))
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    private var emailField = CustomTextfield(placeholder: "Email")
    private var passwordField: UITextField = {
        var passwordField = CustomTextfield(placeholder: "Password")
        passwordField.isSecureTextEntry = true
        return passwordField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

}

extension LoginViewController{
    
    private func layout(){
        // MARK: - Logo layout
        
        view.addSubview(logo)
        logo.centerX(inView: view)
        logo.setDimensions(height: 200, width: view.frame.size.width)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 10)
        
        // MARK: - Stack view layout
        let stackView = UIStackView(arrangedSubviews: [emailField,passwordField])
        stackView.axis = .vertical
        stackView.spacing = 12
        
        view.addSubview(stackView)
        stackView.anchor(top: logo.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 24,paddingLeft: 24,paddingRight: 24)
        
    }
}

//
//  ViewController.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 22.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    let loginViewModel = LoginViewModel()
    
    private var logo: UIImageView = {
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
    
    // MARK: - Login button
    
    private lazy var loginButton: UIButton = {
        var loginButton = CustomButton(title: "Login")
        loginButton.backgroundColor = loginViewModel.loginButtonColor
        loginButton.isEnabled = loginViewModel.loginButtonEnabled
        return loginButton
    }()
    
    // MARK: - Go to register button

    private let gotoRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string: "Don't you have an account? ", attributes: atts)

        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 16)]

        attributedString.append(NSAttributedString(string: "Register", attributes: boldAtts))
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
    // MARK: - Go to register button action

    @objc private func goToRegisterButtonAction() {
        let registerView = LoginViewController()
        navigationController?.pushViewController(registerView, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        textfieldObservers()
        gotoRegisterButton.addTarget(self, action: #selector(goToRegisterButtonAction), for: .touchUpInside)
    }
}

extension LoginViewController {
    private func layout() {
        // MARK: - Logo layout
        
        view.addSubview(logo)
        logo.centerX(inView: view)
        logo.setDimensions(height: 200, width: 350)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        
        // MARK: - Stack view layout

        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        
        view.addSubview(stackView)
        stackView.anchor(top: logo.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingRight: 24)
        
        view.addSubview(gotoRegisterButton)
        gotoRegisterButton.centerX(inView: view)
        gotoRegisterButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
    }
    
    private func textfieldObservers() {
        emailField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
    }
    
    @objc private func textfieldChanged(sender: UITextField) {
        if sender == emailField {
            loginViewModel.email = emailField.text
        } else {
            loginViewModel.password = passwordField.text
        }
        loginButton.backgroundColor = loginViewModel.loginButtonColor
        loginButton.isEnabled = loginViewModel.loginButtonEnabled
    }
}

//
//  RegisterViewController.swift
//  Cryptix
//
//  Created by fe on 22.05.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    let registerViewModel = RegisterViewModel()

    private var logo: UIImageView = {
        var logo = UIImageView(image: UIImage(named: "cryptix"))
        logo.contentMode = .scaleAspectFill
        return logo
    }()

    private var nameField = CustomTextfield(placeholder: "Name")
    private var emailField = CustomTextfield(placeholder: "Email")

    private var passwordField: UITextField = {
        var passwordField = CustomTextfield(placeholder: "Password")
        passwordField.isSecureTextEntry = true
        return passwordField
    }()

    // MARK: - Login button

    private lazy var registerButton: UIButton = {
        var registerButton = CustomButton(title: "Register")
        registerButton.backgroundColor = registerViewModel.loginButtonColor
        registerButton.isEnabled = registerViewModel.loginButtonEnabled
        return registerButton
    }()

    private let gotoLoginButton: UIButton = {
        let button = UIButton(type: .system)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string: "Do you have an account? ", attributes: atts)

        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 16)]

        attributedString.append(NSAttributedString(string: "Login", attributes: boldAtts))
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()

    @objc private func goToLoginButtonAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func register() {
        registerViewModel.registerUser(self, navigationController: navigationController!)
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        layout()
        textfieldObservers()
        gotoLoginButton.addTarget(self, action: #selector(goToLoginButtonAction), for: UIControl.Event.touchUpInside)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
}

extension RegisterViewController {
    private func layout() {
        // MARK: - Logo layout

        view.addSubview(logo)
        logo.centerX(inView: view)
        logo.setDimensions(height: 200, width: 350)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)

        // MARK: - Stack view layout

        let stackView = UIStackView(arrangedSubviews: [nameField, emailField, passwordField, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 12

        view.addSubview(stackView)
        stackView.anchor(top: logo.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingRight: 24)

        view.addSubview(gotoLoginButton)
        gotoLoginButton.centerX(inView: view)
        gotoLoginButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
    }

    private func textfieldObservers() {
        emailField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
        nameField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
    }

    @objc private func textfieldChanged(sender: UITextField) {
        if sender == emailField {
            registerViewModel.email = emailField.text
        } else if sender == passwordField {
            registerViewModel.password = passwordField.text
        } else {
            registerViewModel.name = nameField.text
        }
        registerButton.backgroundColor = registerViewModel.loginButtonColor
        registerButton.isEnabled = registerViewModel.loginButtonEnabled
    }
}

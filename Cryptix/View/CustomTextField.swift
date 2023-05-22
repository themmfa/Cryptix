//
//  CustomTextField.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 22.05.2023.
//

import UIKit

class CustomTextfield: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)

        // MARK: - Left padding for textfield

        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always

        // MARK: - Textfield customization

        // borderStyle = .none
        layer.cornerRadius = 4
        layer.borderColor = UIColor(red: 151.0/255, green: 151.0/255, blue: 151.0/255, alpha: 1).cgColor
        textColor = .white
        backgroundColor = UIColor(red: 29.0/255, green: 29.0/255, blue: 29.0/255, alpha: 1)
        keyboardAppearance = .dark
        setHeight(50)
        tintColor = .white
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(red: 83.0/255, green: 83.0/255, blue: 83.0/255, alpha: 1)])
        autocorrectionType = .no

        passwordRules = UITextInputPasswordRules(descriptor: "")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CustomAlert.swift
//  Cryptix
//
//  Created by fe on 22.05.2023.
//

import UIKit

class CustomAlert {
    static func showAlert(title: String, message: String, viewController: UIViewController, handler: @escaping (UIAlertAction?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

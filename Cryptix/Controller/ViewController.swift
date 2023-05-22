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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

}

extension LoginViewController{
    
    private func layout(){
        view.addSubview(logo)
        logo.centerX(inView: view)
        logo.setDimensions(height: 200, width: view.frame.size.width)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 10)
    }
}

//
//  HomeViewController.swift
//  Cryptix
//
//  Created by fe on 22.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    private lazy var profileButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        button.setImage(UIImage(systemName: "person.crop.circle", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(goToProfilePage), for: .touchUpInside)
        let profileButton = UIBarButtonItem(customView: button)
        return profileButton
    }()

    // TODO: Fix the issue and add to left bar item
    private var menuButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        button.setImage(UIImage(named: "menu", variableValue: 10, configuration: config), for: .normal)
        let profileButton = UIBarButtonItem(customView: button)
        return profileButton
    }()
    
    
    @objc private func goToProfilePage(){
        navigationController?.pushViewController(ProfileViewController(), animated:true)
    }

    private var emptyPageImage = EmptyPage()

    private var addCryptoButton: UIButton = {
        var button = CustomButton(title: "Add Crypto")
        button.isEnabled = true
        button.backgroundColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavBar()
        layout()
        addCryptoButton.addTarget(self, action: #selector(openBottomSheet), for: .touchUpInside)
        
    }
}

extension HomeViewController {
    /// Nav bar setup
    func setupNavBar() {
        navigationController?.setViewControllers([self], animated: true)
        navigationItem.title = "Crypto Addresses"
        navigationController?.setupNavAppearence()
        navigationItem.rightBarButtonItem = profileButton
    }

    private func layout() {
        // MARK: - Empty page

        // TODO: Add firebase checks
        view.addSubview(emptyPageImage)
        emptyPageImage.centerX(inView: view)
        emptyPageImage.centerY(inView: view)
        emptyPageImage.setDimensions(height: 500, width: view.frame.size.width)

        // MARK: - Add crypto button

        view.addSubview(addCryptoButton)
        addCryptoButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 24, paddingBottom: 24, paddingRight: 24)
    }

    // TODO: - Customize bottom sheet
    @objc func openBottomSheet() {
        let detailViewController = UIViewController()
        detailViewController.view.backgroundColor = .red
        let nav = UINavigationController(rootViewController: detailViewController)
        // 1
        nav.modalPresentationStyle = .pageSheet

        // 2
        if let sheet = nav.sheetPresentationController {
            // 3
            sheet.detents = [.medium(), .large()]
        }
        // 4
        present(nav, animated: true, completion: nil)
    }
}

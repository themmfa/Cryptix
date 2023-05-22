//
//  HomeViewController.swift
//  Cryptix
//
//  Created by fe on 22.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    private var profileButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        button.setImage(UIImage(systemName: "person.crop.circle", withConfiguration: config), for: .normal)
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

    private var emptyPageImage = EmptyPage()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavBar()
        layout()
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

        view.addSubview(emptyPageImage)
        emptyPageImage.centerX(inView: view)
        emptyPageImage.centerY(inView: view)
        emptyPageImage.setDimensions(height: 500, width: view.frame.size.width)
    }
}

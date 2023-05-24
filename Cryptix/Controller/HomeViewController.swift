//
//  HomeViewController.swift
//  Cryptix
//
//  Created by fe on 22.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    private let homeViewModel = HomeViewModel()

    private lazy var profileButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        button.setImage(UIImage(systemName: "person.crop.circle", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(goToProfilePage), for: .touchUpInside)
        let profileButton = UIBarButtonItem(customView: button)
        return profileButton
    }()

    private lazy var cryptoAddressCollectionView: UICollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        var cryptoAddressCollectionView = CryptoAddressCollectionViewController(collectionViewLayout: layout, homeViewModel: homeViewModel)
        return cryptoAddressCollectionView
    }()

    // TODO: Fix the issue and add to left bar item
    private var menuButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        button.setImage(UIImage(named: "menu", variableValue: 10, configuration: config), for: .normal)
        let profileButton = UIBarButtonItem(customView: button)
        return profileButton
    }()

    @objc private func goToProfilePage() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
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
        homeViewModel.getCryptoAddresses(in: self, layout: layout, collectionView: cryptoAddressCollectionView.collectionView)
        addCryptoButton.addTarget(self, action: #selector(addCryptoAction), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        homeViewModel.getCryptoAddresses(in: self, layout: layout, collectionView: cryptoAddressCollectionView.collectionView)
    }
}

extension HomeViewController {
    @objc func addCryptoAction() {
        navigationController?.pushViewController(AddCryptoAddressViewController(), animated: true)
    }

    /// Nav bar setup
    func setupNavBar() {
        navigationController?.setViewControllers([self], animated: true)
        navigationItem.title = "Home"
        navigationController?.setupNavAppearence()
        navigationItem.rightBarButtonItem = profileButton
    }

    func layout() {
        // MARK: - Empty page

        // TODO: Add firebase checks
        if homeViewModel.addressList.isEmpty {
            view.addSubview(emptyPageImage)
            emptyPageImage.centerX(inView: view)
            emptyPageImage.centerY(inView: view)
            emptyPageImage.setDimensions(height: 500, width: view.frame.size.width)
        }
        else {
            view.addSubview(cryptoAddressCollectionView.view)
            cryptoAddressCollectionView.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 500)
            cryptoAddressCollectionView.view.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 100, paddingRight: 12)
        }

        // MARK: - Add crypto button

        view.addSubview(addCryptoButton)
        addCryptoButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 24, paddingBottom: 24, paddingRight: 24)
    }
}

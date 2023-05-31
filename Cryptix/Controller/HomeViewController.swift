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
        navigationController?.pushViewController(ProfileViewController(homeViewModel: homeViewModel), animated: true)
    }

    private var emptyPageImage = EmptyPage()

    private var addCryptoButton: UIButton = {
        var button = CustomButton(title: "Add Crypto")
        button.isEnabled = true
        button.backgroundColor = .black
        return button
    }()

    let activityIndicatorController = CustomActivityIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        homeViewModel.delegate = self
        setupNavBar()
        addCryptoButton.addTarget(self, action: #selector(addCryptoAction), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        activityIndicatorController.startAnimating(in: self)
        homeViewModel.getCryptoAddresses()
    }
}

extension HomeViewController {
    @objc func addCryptoAction() {
        navigationController?.pushViewController(AddCryptoAddressViewController(homeViewModel: homeViewModel), animated: true)
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
            cryptoAddressCollectionView.view.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 74, paddingRight: 12)
        }

        // MARK: - Add crypto button

        view.addSubview(addCryptoButton)
        addCryptoButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 24, paddingBottom: 24, paddingRight: 24)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func addCrypto(_ response: ApiResponse?) {
        //
    }

    func deleteCrypto(_ response: ApiResponse) {
        //
    }

    func getCryptoAddress(_ response: ApiResponse) {
        DispatchQueue.main.sync { [weak self] in
            if response.isSuccess {
                self?.activityIndicatorController.stopAnimating()
                self?.layout()
                self?.cryptoAddressCollectionView.collectionView.reloadData()
            }
            if !response.isSuccess {
                self?.activityIndicatorController.stopAnimating()
                CustomAlert.showAlert(title: "Error", message: response.errorMessage ?? "", viewController: self!) { _ in }
            }
        }
    }

    func getUserInfo(_ response: ApiResponse) {
        //
    }
}

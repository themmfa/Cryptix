//
//  CryptoAddressCollectionViewCollectionViewController.swift
//  Cryptix
//
//  Created by fe on 24.05.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class CryptoAddressCollectionViewController: UICollectionViewController {
    let homeViewModel: HomeViewModel

    var bottomSheetView: CustomBottomSheetViewController?
    
    let navController:UINavigationController

    init(collectionViewLayout: UICollectionViewLayout, homeViewModel: HomeViewModel,nav:UINavigationController) {
        self.homeViewModel = homeViewModel
        self.navController = nav
        super.init(collectionViewLayout: collectionViewLayout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        collectionView!.register(CustomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    @objc func loadList(notification: NSNotification) {
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.addressList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        cell.nameField.text = homeViewModel.addressList[indexPath.row]?.name
        cell.exchangeField.text = homeViewModel.addressList[indexPath.row]?.exchange
        cell.cryptoAddressField.text = homeViewModel.addressList[indexPath.row]?.cryptoAddress
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.bottomSheetView = CustomBottomSheetViewController(cryptoModel: homeViewModel.addressList[indexPath.row]!, homeViewModel: homeViewModel,nav: self.navController)

        bottomSheetView!.modalPresentationStyle = .pageSheet

        if let sheet = bottomSheetView!.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in
                300
            })]
            sheet.preferredCornerRadius = 12
            sheet.prefersGrabberVisible = true
        }

        // MARK: - By presenting the UIActivityViewController from the window's root view controller, we avoid potential issues related to the detached view controller. This approach ensures that the view controller presenting the activity view controller is always a part of the view hierarchy.
        
        present(bottomSheetView!, animated: true)

    }
}

extension CryptoAddressCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 60)
    }
}



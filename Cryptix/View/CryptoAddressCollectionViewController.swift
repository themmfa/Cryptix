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

    init(collectionViewLayout: UICollectionViewLayout, homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(collectionViewLayout: collectionViewLayout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.register(CustomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.addressList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        return cell
    }
}

extension CryptoAddressCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 100)
    }
}

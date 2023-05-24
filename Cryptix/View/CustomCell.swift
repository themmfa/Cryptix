//
//  CustomCellCollectionViewCell.swift
//  Cryptix
//
//  Created by fe on 24.05.2023.
//

import UIKit

class CustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        contentView.layer.cornerRadius = 8
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

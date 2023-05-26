//
//  CustomInfoContainer.swift
//  Cryptix
//
//  Created by fe on 26.05.2023.
//

import UIKit

class CustomInfoContainer: UIView {
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        var image = UIImage(systemName: "bitcoinsign.circle.fill")
        imageView.image = image
        imageView.setDimensions(height: 30, width: 30)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        imageView.layer.cornerRadius = 20 / 2
        return imageView
    }()

    lazy var nameField: UILabel = {
        var nameField = UILabel()
        nameField.textColor = .black
        nameField.font = .boldSystemFont(ofSize: 16)
        return nameField
    }()

    lazy var exchangeField: UILabel = {
        var exchangeField = UILabel()
        exchangeField.textColor = .black
        exchangeField.font = .systemFont(ofSize: 16)

        return exchangeField
    }()

    lazy var cryptoAddressField: UILabel = {
        var cryptoAddressField = UILabel()
        cryptoAddressField.textColor = .black
        cryptoAddressField.font = .systemFont(ofSize: 16)
        return cryptoAddressField
    }()

    lazy var infoRow: UIStackView = {
        var infoRow = UIStackView(arrangedSubviews: [nameField, exchangeField])
        infoRow.axis = .horizontal
        infoRow.spacing = 4
        infoRow.distribution = .equalCentering
        return infoRow
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 4
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomInfoContainer {
    private func layout() {
        // MARK: - Image view

        addSubview(imageView)
        imageView.centerY(inView: self)
        imageView.anchor(left: leftAnchor, paddingLeft: 12)

        let stackView = UIStackView(arrangedSubviews: [infoRow, cryptoAddressField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: imageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
    }
}

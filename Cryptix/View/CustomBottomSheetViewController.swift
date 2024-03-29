//
//  CustomBottomSheetViewController.swift
//  Cryptix
//
//  Created by fe on 26.05.2023.
//

import UIKit

class CustomBottomSheetViewController: UIViewController {
    var cryptoModel: CryptoAddressModel
    let homeViewModel: HomeViewModel
    let navController: UINavigationController
    lazy var editVC = EditCryptoAddressViewController(homeViewModel: homeViewModel, cryptoModel: cryptoModel)
    private var copyView = CustomCopyShare(text: "Copy", imageVar: "doc.on.doc")

    private var shareView = CustomCopyShare(text: "Share", imageVar: "square.and.arrow.up")

    lazy var activityIndicatorController = CustomActivityIndicator()

    lazy var customContainerView: UIView = {
        var customContainerView = CustomInfoContainer()
        customContainerView.imageView.sd_setImage(with: URL(string: cryptoModel.cryptoImage!))
        customContainerView.nameField.text = cryptoModel.name
        customContainerView.exchangeField.text = cryptoModel.exchange
        customContainerView.cryptoAddressField.text = cryptoModel.cryptoAddress
        return customContainerView
    }()

    @objc private func share(_ sender: UIButton) {
        let items: [Any] = [cryptoModel.cryptoAddress!]
        let shareActivityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        shareActivityViewController.excludedActivityTypes = [
            .addToReadingList,
            .assignToContact,
            .markupAsPDF,
            .openInIBooks
        ]

        // Present the activity view controller
        if let popoverPresentationController = shareActivityViewController.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY / 2, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }

        present(shareActivityViewController, animated: true, completion: nil)
    }

    private var editButton: UIButton = {
        var editButton = CustomButton(title: "Edit")
        editButton.isEnabled = true
        editButton.backgroundColor = .black
        return editButton
    }()

    @objc func editButtonAction() {
        dismiss(animated: true)
        navController.pushViewController(editVC, animated: true)
    }

    private var deleteButton: UIButton = {
        var deleteButton = UIButton()
        var image = UIImage(systemName: "trash")
        deleteButton.tintColor = .black
        deleteButton.setImage(image, for: .normal)
        return deleteButton
    }()

    init(cryptoModel: CryptoAddressModel, homeViewModel: HomeViewModel, nav: UINavigationController) {
        self.cryptoModel = cryptoModel
        self.homeViewModel = homeViewModel
        self.navController = nav
        super.init(nibName: nil, bundle: nil)
    }

    @objc func deleteButtonAction() {
        homeViewModel.deleteAddress(cryptoModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        modalTransitionStyle = .coverVertical
        customContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyValuePressed)))
        copyView.button.addTarget(self, action: #selector(copyValuePressed), for: .touchUpInside)
        shareView.button.addTarget(self, action: #selector(share), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
    }

    @objc func copyValuePressed() {
        UIPasteboard.general.string = cryptoModel.cryptoAddress
        showToast(message: "Your crypto address copied to clipboard.")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomBottomSheetViewController {
    private func layout() {
        view.addSubview(customContainerView)
        customContainerView.setHeight(60)
        customContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingRight: 12)

        view.addSubview(copyView)
        copyView.anchor(top: customContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingRight: 12)

        view.addSubview(shareView)
        shareView.anchor(top: copyView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingRight: 12)

        let stackView = UIStackView(arrangedSubviews: [editButton, deleteButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        view.addSubview(stackView)
        stackView.anchor(top: shareView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingRight: 12)
    }
}

private class CustomCopyShare: UIStackView {
    var labelText: String
    var imageText: String

    lazy var label: UILabel = {
        var label = UILabel()
        label.text = self.labelText
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()

    lazy var button: UIButton = {
        var button = UIButton()
        var image = UIImage(systemName: self.imageText)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.setDimensions(height: 30, width: 30)
        return button
    }()

    init(text: String, imageVar: String) {
        self.labelText = text
        self.imageText = imageVar
        super.init(frame: .zero)
        addArrangedSubview(label)
        addArrangedSubview(button)
        axis = .horizontal
        distribution = .equalSpacing
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

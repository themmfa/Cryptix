//
//  EditCryptoAddressViewController.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 1.06.2023.
//

import UIKit

class EditCryptoAddressViewController: UIViewController {
    let homeViewModel: HomeViewModel
    let activityIndicatorController = CustomActivityIndicator()
    let cryptoAddressModel: CryptoAddressModel

    init(homeViewModel: HomeViewModel, cryptoModel: CryptoAddressModel) {
        self.homeViewModel = homeViewModel
        self.cryptoAddressModel = cryptoModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var cryptoAddressField: UITextField = {
        var cryptoAddressField = CustomTextfield(placeholder: "Crypto Address")
        cryptoAddressField.text = self.cryptoAddressModel.cryptoAddress
        return cryptoAddressField
    }()

    private let cryptoAddressTitle: UILabel = {
        var cryptoAddressTitle = UILabel()
        cryptoAddressTitle.text = "Crypto Address"
        cryptoAddressTitle.textColor = .black
        cryptoAddressTitle.font = .boldSystemFont(ofSize: 16)
        return cryptoAddressTitle
    }()

    private lazy var nameField: UITextField = {
        var nameField = CustomTextfield(placeholder: "Name")
        nameField.text = self.cryptoAddressModel.name
        return nameField
    }()

    private let nameTitle: UILabel = {
        var nameTitle = UILabel()
        nameTitle.text = "Name"
        nameTitle.textColor = .black
        nameTitle.font = .boldSystemFont(ofSize: 16)
        return nameTitle
    }()

    private lazy var exchangeField: UITextField = {
        var exchangeField = CustomTextfield(placeholder: "Exchange")
        exchangeField.text = self.cryptoAddressModel.exchange
        return exchangeField
    }()

    private let exchangeTitle: UILabel = {
        var exchangeTitle = UILabel()
        exchangeTitle.text = "Exchange"
        exchangeTitle.textColor = .black
        exchangeTitle.font = .boldSystemFont(ofSize: 16)
        return exchangeTitle
    }()

    private lazy var saveButton: UIButton = {
        var saveButton = CustomButton(title: "Save")
        saveButton.backgroundColor = editButtonColor
        saveButton.isEnabled = editButtonEnabled
        return saveButton
    }()

    @objc func saveButtonAction() {
        activityIndicatorController.startAnimating(in: self)
        homeViewModel.editAddress(editedCryptoModel: CryptoAddressModel(name: nameField.text, exchange: exchangeField.text, cryptoAddress: cryptoAddressField.text, cryptoImage: nil), currentCryptoModel: cryptoAddressModel)
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        layout()
        self.dissmissableKeyboard()
        textfieldObservers()
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
    }
}

extension EditCryptoAddressViewController {
    private func layout() {
        let stackView1 = CustomStackView(subviewList: [nameTitle, nameField])
        let stackView2 = CustomStackView(subviewList: [exchangeTitle, exchangeField])
        let stackView3 = CustomStackView(subviewList: [cryptoAddressTitle, cryptoAddressField])

        let containerView = CustomStackView(subviewList: [stackView1, stackView2, stackView3, saveButton])
        containerView.spacing = 20

        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 16, paddingRight: 16)
    }

    func textfieldObservers() {
        nameField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
        exchangeField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
        cryptoAddressField.addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
    }

    @objc func textfieldChanged(sender: UITextField) {
        if sender == nameField {
            homeViewModel.name = nameField.text
        } else if sender == exchangeField {
            homeViewModel.exchange = exchangeField.text
        } else {
            homeViewModel.cryptoAddress = cryptoAddressField.text
        }
        saveButton.backgroundColor = editButtonColor
        saveButton.isEnabled = editButtonEnabled
    }

    var isFormValid: Bool {
        return nameField.text!.isEmpty == false && exchangeField.text!.isEmpty == false && cryptoAddressField.text!.isEmpty == false
    }

    var editButtonColor: UIColor {
        return isFormValid ? .black : .gray
    }

    var editButtonEnabled: Bool {
        return isFormValid
    }
}

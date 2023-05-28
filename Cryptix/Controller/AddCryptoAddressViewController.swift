//
//  AddCryptoAddressViewController.swift
//  Cryptix
//
//  Created by fe on 23.05.2023.
//

import UIKit

class AddCryptoAddressViewController: UIViewController {
    let homeViewModel: HomeViewModel

    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let cryptoAddressField = CustomTextfield(placeholder: "Crypto Address")
    private let cryptoAddressTitle: UILabel = {
        var cryptoAddressTitle = UILabel()
        cryptoAddressTitle.text = "Crypto Address"
        cryptoAddressTitle.textColor = .black
        cryptoAddressTitle.font = .boldSystemFont(ofSize: 16)
        return cryptoAddressTitle
    }()

    private let nameField = CustomTextfield(placeholder: "Name")
    private let nameTitle: UILabel = {
        var nameTitle = UILabel()
        nameTitle.text = "Name"
        nameTitle.textColor = .black
        nameTitle.font = .boldSystemFont(ofSize: 16)
        return nameTitle
    }()

    private let exchangeField = CustomTextfield(placeholder: "Exchange")
    private let exchangeTitle: UILabel = {
        var exchangeTitle = UILabel()
        exchangeTitle.text = "Exchange"
        exchangeTitle.textColor = .black
        exchangeTitle.font = .boldSystemFont(ofSize: 16)
        return exchangeTitle
    }()

    private lazy var addCryptoButton: UIButton = {
        var addCryptoButton = CustomButton(title: "Add")
        addCryptoButton.backgroundColor = homeViewModel.addCryptoButtonColor
        addCryptoButton.isEnabled = homeViewModel.addCryptoButtonEnabled
        return addCryptoButton
    }()

    @objc func addCryptoAddress() {
        homeViewModel.addCryptoAddress(in: self, with: navigationController!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        textfieldObservers()
        addCryptoButton.addTarget(self, action: #selector(addCryptoAddress), for: .touchUpInside)
    }
}

extension AddCryptoAddressViewController {
    private func layout() {
        let stackView1 = CustomStackView(subviewList: [nameTitle, nameField])
        let stackView2 = CustomStackView(subviewList: [exchangeTitle, exchangeField])
        let stackView3 = CustomStackView(subviewList: [cryptoAddressTitle, cryptoAddressField])

        let containerView = CustomStackView(subviewList: [stackView1, stackView2, stackView3, addCryptoButton])
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
        addCryptoButton.backgroundColor = homeViewModel.addCryptoButtonColor
        addCryptoButton.isEnabled = homeViewModel.addCryptoButtonEnabled
    }
}

class CustomStackView: UIStackView {
    init(subviewList: [UIView]) {
        super.init(frame: .zero)
        for view in subviewList {
            addArrangedSubview(view)
        }
        axis = .vertical
        spacing = 10
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

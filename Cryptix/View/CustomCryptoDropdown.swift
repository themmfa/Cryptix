//
//  CustomDropdown.swift
//  Cryptix
//
//  Created by fe on 4.06.2023.
//

import SDWebImage
import UIKit

class CustomCryptoDropdownButton: UITextField {
    private var pickerView = UIPickerView()
    var homeViewModel: HomeViewModel
    
    var options: CryptoList = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    var selectedOption: String? {
        didSet {
            if let selectedOption = selectedOption {
                text = selectedOption
            }
        }
    }
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(frame: .zero)
        setupPickerView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        inputView = pickerView
        selectedOption = options.first?.name
        textAlignment = .left
        text = "Select Crypto"
        createToolbar()
    }
    
    private func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        resignFirstResponder()
    }
}

extension CustomCryptoDropdownButton: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let rowView = UIView()
        rowView.backgroundColor = .clear
            
        let iconImageView = UIImageView()
        iconImageView.sd_setImage(with: URL(string: options[row].image!))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        rowView.addSubview(iconImageView)
            
        let label = UILabel()
        label.text = options[row].name
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.frame = CGRect(x: 24, y: 0, width: pickerView.bounds.width - 24, height: 24)
        rowView.addSubview(label)
            
        return rowView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = options[row].name
        homeViewModel.name = selectedOption
        homeViewModel.cryptoImage = options[row].image
    }
}

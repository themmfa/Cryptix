//
//  CustomButton.swift
//  Cryptix
//
//  Created by Fatih Erdoğan on 22.05.2023.
//

import UIKit

class CustomButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setHeight(50)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

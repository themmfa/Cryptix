//
//  EmptyPage.swift
//  Cryptix
//
//  Created by fe on 22.05.2023.
//

import UIKit

class EmptyPage: UIImageView {
    init() {
        super.init(frame: .zero)
        image = UIImage(named: "empty_page")
        contentMode = .scaleAspectFill
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

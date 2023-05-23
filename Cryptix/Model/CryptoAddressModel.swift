//
//  CryptoAddressModel.swift
//  Cryptix
//
//  Created by fe on 23.05.2023.
//

import Foundation

struct CryptoAddressModel {
    var name: String?
    var exchange: String?
    var cryptoAddress: String?

    init(name: String? = nil, exchange: String? = nil, cryptoAddress: String? = nil) {
        self.name = name
        self.exchange = exchange
        self.cryptoAddress = cryptoAddress
    }
}

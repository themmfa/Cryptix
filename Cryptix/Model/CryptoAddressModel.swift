//
//  CryptoAddressModel.swift
//  Cryptix
//
//  Created by fe on 23.05.2023.
//

import Foundation

struct CryptoAddressModel: Decodable {
    var name: String?
    var exchange: String?
    var cryptoAddress: String?
    var cryptoImage: String?

    init(name: String? = nil, exchange: String? = nil, cryptoAddress: String? = nil, cryptoImage: String?) {
        self.name = name
        self.exchange = exchange
        self.cryptoAddress = cryptoAddress
        self.cryptoImage = cryptoImage
    }
}

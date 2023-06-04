//
//  CryptoApiService.swift
//  Cryptix
//
//  Created by fe on 4.06.2023.
//

import Foundation

class CryptoApiService {
    private let cryptoListApiEndpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc"

    private let exchangeListApiEndpoint = "https://api.coingecko.com/api/v3/exchanges?per_page=50"

    func getCryptoList() async throws -> CryptoList? {
        guard let url = URL(string: cryptoListApiEndpoint) else {
            throw CustomError.badUrl(message: "Wrong Url")
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.badRequest(message: "Bad request")
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(CryptoList.self, from: data)
        } catch {
            throw CustomError.invalidData(message: error.localizedDescription)
        }
    }
    
    
    func getExchangeList() async throws -> ExhangeList? {
        guard let url = URL(string: exchangeListApiEndpoint) else {
            throw CustomError.badUrl(message: "Wrong Url")
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.badRequest(message: "Bad request")
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(ExhangeList.self, from: data)
        } catch {
            throw CustomError.invalidData(message: error.localizedDescription)
        }
    }
}

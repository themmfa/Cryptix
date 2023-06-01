//
//  HomeViewModel.swift
//  Cryptix
//
//  Created by fe on 24.05.2023.
//

import UIKit

protocol HomeViewModelDelegate {
    func addCrypto(_ response: ApiResponse)
    func deleteCrypto(_ response: ApiResponse)
    func getCryptoAddress(_ response: ApiResponse)
    func getUserInfo(_ response: ApiResponse)
    func signOut(_ response: ApiResponse)
    func edit(_ response: ApiResponse)
}

class HomeViewModel {
    var addressList: [CryptoAddressModel?] = []
    var user: UserModel?

    var name: String?
    var exchange: String?
    var cryptoAddress: String?

    var delegate: HomeViewModelDelegate?

    private var firebaseApiService = FirebaseApiService()

    var isFormValid: Bool {
        return name?.isEmpty == false && exchange?.isEmpty == false && cryptoAddress?.isEmpty == false
    }

    var addCryptoButtonColor: UIColor {
        return isFormValid ? .black : .gray
    }

    var addCryptoButtonEnabled: Bool {
        return isFormValid
    }

    func addCryptoAddress(in view: UIViewController, with navigationController: UINavigationController) {
        Task {
            do {
                try await firebaseApiService.addCryptoAddress(with: CryptoAddressModel(name: name, exchange: exchange, cryptoAddress: cryptoAddress))
                delegate?.addCrypto(ApiResponse(isSuccess: true))

            } catch {
                delegate?.addCrypto(ApiResponse(errorMessage: error.localizedDescription, isSuccess: false))
            }
        }
    }

    func deleteAddress(_ cryptoModel: CryptoAddressModel) {
        Task {
            do {
                let cryptoList = try await firebaseApiService.deleteCryptoAddress(with: cryptoModel)
                self.addressList = cryptoList
                delegate?.deleteCrypto(ApiResponse(isSuccess: true))

            } catch {
                delegate?.deleteCrypto(ApiResponse(errorMessage: error.localizedDescription, isSuccess: false))
            }
        }
    }

    func getCryptoAddresses() {
        Task {
            do {
                addressList = try await firebaseApiService.getCryptoAddresses()
                delegate?.getCryptoAddress(ApiResponse(isSuccess: true))

            } catch {
                delegate?.getCryptoAddress(ApiResponse(errorMessage: error.localizedDescription, isSuccess: false))
            }
        }
    }

    func getUserInfo() {
        Task {
            do {
                user = try await firebaseApiService.getUserInfo()
                delegate?.getUserInfo(ApiResponse(isSuccess: true))

            } catch {
                delegate?.getUserInfo(ApiResponse(errorMessage: error.localizedDescription, isSuccess: false))
            }
        }
    }

    func signout() {
        Task {
            do {
                try await self.firebaseApiService.signOut()
                delegate?.signOut(ApiResponse(isSuccess: true))

            } catch {
                delegate?.signOut(ApiResponse(errorMessage: error.localizedDescription, isSuccess: false))
            }
        }
    }
    
    func editAddress(_ cryptoModel: CryptoAddressModel) {
        Task {
            do {
                self.addressList = try await self.firebaseApiService.editCryptoAddress(with: cryptoModel)
                delegate?.edit(ApiResponse(isSuccess: true))

            } catch {
                delegate?.edit(ApiResponse(errorMessage: error.localizedDescription, isSuccess: false))
            }
        }
    }
}

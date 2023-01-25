//
//  CryptoModel.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

class MainModel {
    
    func fetchCoins() async throws -> [Coin]{
        let coins = try await CryptoService.getCoins()
        return coins
    }
}

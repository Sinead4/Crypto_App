//
//  DetailModel.swift
//  Crypto App
//
//  Created by Jan Wälti on 24.01.23.
//

import Foundation

class DetailModel {

    func fetchPrices(id: String, currency: String, days: Int) async throws -> Prices {
        let prices = try await CryptoService.getPrices(id: id, currency: currency, days: days)
        return prices
    }
}

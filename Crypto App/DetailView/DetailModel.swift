//
//  DetailModel.swift
//  Crypto App
//
//  Created by Jan Wälti on 24.01.23.
//

import Foundation

class DetailModel {

    func fetchPrices(id: String, from: Int, to: Int) async throws -> [Prices] {
        let prices = try await CryptoService.getPrices(id: id, from: from, to: to)
        return prices
    }
}

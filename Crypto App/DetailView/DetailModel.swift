//
//  DetailModel.swift
//  Crypto App
//
//  Created by Jan Wälti on 24.01.23.
//

import Foundation

class DetailModel {
    let service: DataService
    
    init(service: DataService) {
        self.service = service
    }
    
    func fetchPriceHistory(id: String, from: Int, to: Int) async throws -> PriceHistory {
        let priceHistory = try await CryptoService.getPriceHistory(id: id, from: from, to: to)
        return priceHistory
    }
}

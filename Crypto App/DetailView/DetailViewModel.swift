//
//  DetailViewModel.swift
//  Crypto App
//
//  Created by Jan Wälti on 24.01.23.
//

import Foundation
import SwiftUI

class DetailViewModel: ObservableObject {
    
    let model = DetailModel()
    
    @Published var prices: [Prices] = []
    @Published var priceItems: [PriceItem] = []
    @Published var errorText: String?
        
    func loadPrices(id: String, from: Int, to: Int) {
        Task {
            do {
                let prices = try await model.fetchPrices(id: id, from: from, to: to)
                print(prices)
                DispatchQueue.main.async {
                    self.prices = prices
                }
            } catch {
                DispatchQueue.main.async {
                    if let error = error as? NetworkError {
                        self.errorText = error.errDescription
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.errorText = nil
                }
            }
        }
    }
    
    func convertPricesToPriceItem(prices: [Prices]) {
        var priceItems: [PriceItem] = []
        for price in prices {
            for i in 0..<price.prices.count {
                let priceItem = PriceItem(price: price.prices[i][1], value: price.marketCaps[i][0])
                priceItems.append(priceItem)
            }
        }
    }
}

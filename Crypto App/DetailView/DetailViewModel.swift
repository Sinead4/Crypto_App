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
    
    @Published var prices = Prices(prices: [], marketCaps: [], totalVolumes: [])
    @Published var priceItems: [PriceItem] = []
    @Published var errorText: String?
    
    
    init(id: String, currency: String, days: Int) {
        self.loadPrices(id: id, currency: currency, days: days)
    }
        
    func loadPrices(id: String, currency: String, days: Int) {
        Task {
            do {
                let prices = try await model.fetchPrices(id: id, currency: currency, days: days)
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
    
    
    /*
    func convertPricesToPriceItem(prices: Prices) {
        var priceItems: PriceItem
        for price in prices {
            for i in 0..<price.prices.count {
                let priceItem = PriceItem(price: price.prices[i][1], value: price.marketCaps[i][0])
                priceItems.append(priceItem)
            }
        }
    }
     
     */
}

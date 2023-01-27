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
    
    @Published var fetchedPrices = Price(prices: [], marketCaps: [], totalVolumes: [])
    @Published var priceChartItems: [ChartPrice] = []
    @Published var errorText: String?
    
    public func loadPrices(id: String, currency: String, days: Int) async throws -> Void {
        Task {
            do {
                let prices = try await model.fetchPrices(id: id, currency: currency, days: days)
                DispatchQueue.main.async {
                    self.fetchedPrices = prices
                    self.convertPricesToPriceChartItems(prices: prices)
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
    
    public func convertPricesToPriceChartItems(prices: Price) {
        priceChartItems = []
        for price in prices.prices {
            priceChartItems.append(ChartPrice(price: price[1], unixTime: price[0]))
        }
    }
}

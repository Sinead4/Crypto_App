//
//  DetailViewModel.swift
//  Crypto App
//
//  Created by Jan Wälti on 24.01.23.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    let model = DetailModel()
    
    @Published var prices: [Prices] = []
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
}

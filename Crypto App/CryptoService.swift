//
//  CryptoService.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

struct CryptoService{
                
    var httpMethod: String {
        switch self {
        default: return "GET"
        }
    }
    
    static func getCoins() async throws -> [Coin] {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")!
        
        let localRequest = URLRequest(url: url)
        
        let request = try await NetworkService.load(from: localRequest, convertTo: [Coin].self)
        
        return request
    }
    
    static func getPrices(id: String, currency: String, days: Int) async throws -> Prices {
            let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)/market_chart?vs_currency=\(currency)&days=\(days)")!
            
            let localRequest = URLRequest(url: url)
        
            let request = try await NetworkService.load(from: localRequest, convertTo: Prices.self)
                    
        return request
        }
}

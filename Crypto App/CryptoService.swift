//
//  CryptoService.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

class CryptoService{
    
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
    
    static func getPrices(id: String, from: Int, to: Int) async throws -> [Prices] {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)/market_chart/range?vs_currency=usd&from=\(from)&to=\(to)")!
        let localRequest = URLRequest(url: url)
        let request = try await NetworkService.load(from: localRequest, convertTo: [Prices].self)
        
        return request
    }
}

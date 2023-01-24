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
    
    static func getCoinList() async throws -> [coin]{
        let coinURL = URL(string: "https://api.coingecko.com/api/v3/coins/list")!
        let coinURLRequest = URLRequest(url: coinURL)
        
        let result = try await NetworkService.load(from: coinURLRequest, convertTo: [coin].self)
        
        return result
        
    }
    

    static func getCoinMarket() async throws -> [CoinMarketElement] {

        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")!
        let localRequest = URLRequest(url: url)
        let request = try await NetworkService.loadCoins(from: localRequest, convertTo: [CoinMarketElement].self)
        
        print("request in Service ist: \(request)")

        return request
        
    }
    
//    static func getCoinBug() async throws //-> [CoinMarketElement]
//    {
//        print("coinID: \(coinId.id)")
//        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")!
        
//        let localRequest = URLRequest(url: url)
        
//        print("localrequest ist: \(localRequest)")
//        try await NetworkService.testload(from: localRequest, convertTo: CoinMarketElement.self)
        
//        let request =
//        try await NetworkService.loadCoinsBug(from: localRequest, convertTo: [CoinMarketElement].self)
        
        
//        let request = try await MockService.load(from: localRequest, convertTo: [CoinMarketElement].self)
//        print("request in Service ist: \(request)")
      
//        return request
        
//    }

    
}

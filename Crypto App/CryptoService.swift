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
    
    static func getCoinList() async throws -> [Coin]{
        let coinURL = URL(string: "https://api.coingecko.com/api/v3/coins/list")!
        let coinURLRequest = URLRequest(url: coinURL)
        
        let result = try await NetworkService.load(from: coinURLRequest, convertTo: [Coin].self)
        
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

    
    static func getPriceHistory(id: String, from: Int, to: Int) async throws -> PriceHistory {
        let priceHistoryURL = URL(string: "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_currency=usd&from=1674550000&to=1674570012")!
        
        //let myUrl: String = "https://api.coingecko.com/api/v3/coins/" + id +
        
        let priceHistoryURLRequest = URLRequest(url: priceHistoryURL)
        
        let result = try await NetworkService.load(from: priceHistoryURLRequest, convertTo: PriceHistory.self)
        
        return result
    }
}

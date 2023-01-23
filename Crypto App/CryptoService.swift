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
}

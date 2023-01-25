//
//  CryptoModel.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

class Model {
    
    
    func getCoinList() async throws -> [Coin]{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 100
        
        let result = try await CryptoService.getCoinList()
        
        if(result.isEmpty){
            throw NetworkError.noData
        }
        
        return result
        
    }
    
    func getCoinMarket() async throws -> [CoinMarketElement]{
        var coinListMarketTest: [CoinMarketElement]
            
        coinListMarketTest = try await CryptoService.getCoinMarket()
            
        return coinListMarketTest
        }
        
    
//    func getCoinBug() async throws //-> [CoinMarketElement]
//    {
//        let coins = try await getCoinList()
//        var coinListMarketTest: [CoinMarketElement]
            
//         try await CryptoService.getCoinBug()
            
//        return coinListMarketTest
//        }
    
    
}



    

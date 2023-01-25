//
//  DataStructure.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

struct DummyPingStructure: Identifiable, Codable {
    let id: Int
    let text: String

}

struct Coin: Identifiable, Codable{
    let id: String
    let name: String
}


struct CoinMarketContainer: Codable{

    var myCoinMarket: [CoinMarketElement]

}

// MARK: - CoinMarketElement
struct CoinMarketElement: Identifiable,Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank: Double
    let fullyDilutedValuation: Double?
    let totalVolume: Double
    let high24H, low24H: Double
    let priceChange24H, priceChangePercentage24H: Double
    let marketCapChange24H: Double
    let marketCapChangePercentage24H: Double
    let circulatingSupply, totalSupply: Double?
    let maxSupply: Double?
    let ath: Double
    let athChangePercentage: Double
    let athDate: String
    let atl, atlChangePercentage: Double
    let atlDate: String
    let lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
    }
    
}

struct PriceHistory: Identifiable, Codable {
    var id: Int
    
    
    
    

}


struct PriceItem: Identifiable, Codable {
    var id = UUID()
    let price: Int
    var date: Date {
        print(Date(timeIntervalSince1970: Double(price) / 1000))
        return Date(timeIntervalSince1970: Double(price) / 1000)
    }
    var dateAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    let value: Double
}



struct Price {
    let day: Date
    var price: Int
}



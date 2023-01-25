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

struct coin: Identifiable, Codable{
    let id: String
    let symbol: String
    let name: String
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

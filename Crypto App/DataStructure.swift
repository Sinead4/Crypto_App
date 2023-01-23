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

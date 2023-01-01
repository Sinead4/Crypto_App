//
//  DataStructure.swift
//  Crypto App
//
//  Created by Sinead on 22.12.22.
//

import Foundation

//beispiel code von Ingo
struct DummyPingStructure: Identifiable, Codable {
    let id: Int
    let text: String

}

struct coin: Identifiable, Codable{
    let id: String
    let symbol: String
    let name: String
}

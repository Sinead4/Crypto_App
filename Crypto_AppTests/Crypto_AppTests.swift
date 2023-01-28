//
//  Crypto_AppTests.swift
//  Crypto_AppTests
//
//  Created by Sinead on 28.01.23.
//

@testable import Crypto_App
import XCTest

final class Crypto_AppTests: XCTestCase {
    
    func testPrices() async throws {
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=1")!
        let localRequest = URLRequest(url: url)
        let price = try await MockService.load(from: localRequest, convertTo: Price.self)

        XCTAssertNotNil(price)
        
        let price2 = try await MockService.load(from: localRequest, convertTo: Price.self)
        XCTAssertNotNil(price2)
        XCTAssertEqual(price, price2)
        XCTAssertEqual(price.prices[0][0], Double(1674550374910))
        
    }
    
    func testCoins() async throws {
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")!
        let localRequest = URLRequest(url: url)
        let coins = try await MockService.load(from: localRequest, convertTo: [Coin].self)

        XCTAssertNotNil(coins)
        XCTAssertEqual(coins[0].symbol,"btc" )
        XCTAssertEqual(coins[3].symbol,"usdc" )
        XCTAssertNotEqual(coins[0], coins[1])
        
    }

}

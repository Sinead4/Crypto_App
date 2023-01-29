@testable import Crypto_App
import XCTest

final class Crypto_AppTests: XCTestCase {
    
    func testPrices() async throws {
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=1")!
        let localRequest = URLRequest(url: url)
        
        let price = try await MockService.load(from: localRequest, convertTo: Price.self)
        
        XCTAssertNotNil(price)
        
        XCTAssertEqual(price.prices[0][0], 1674550374910)
        XCTAssertEqual(price.prices[0][1], 23063.901776933366)
        XCTAssertEqual(price.prices[1][0], 1674550519050)
        XCTAssertEqual(price.prices[1][1], 23074.660478399)
        
        XCTAssertEqual(price.prices.count, 66)
    }
    
    func testCoins() async throws {
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")!
        let localRequest = URLRequest(url: url)
        let coins = try await MockService.load(from: localRequest, convertTo: [Coin].self)
        
        XCTAssertNotNil(coins)
        
        XCTAssertEqual(coins[0].id, "bitcoin")
        XCTAssertEqual(coins[0].symbol, "btc")
        XCTAssertEqual(coins[0].name, "Bitcoin")
        XCTAssertEqual(coins[0].image, "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579")
        XCTAssertEqual(coins[0].currentPrice, 23066)
        XCTAssertEqual(coins[0].marketCap, 444462237754)
        XCTAssertEqual(coins[0].marketCapRank, 1)
        XCTAssertEqual(coins[0].totalVolume, 37421302907)
        XCTAssertEqual(coins[0].high24H, 23165)
        XCTAssertEqual(coins[0].low24H, 22716)
        XCTAssertEqual(coins[0].priceChange24H, 332.76)
        XCTAssertEqual(coins[0].priceChangePercentage24H, 1.46378)
        
        XCTAssertEqual(coins.count, 4)

        XCTAssertNotEqual(coins[0], coins[1])
    }
}

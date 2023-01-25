//
//  CryptoViewModel.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

class MainViewModel: ObservableObject {
    
    let model = MainModel()
    
    @Published var coinListMarket: [Coin] = []
    @Published var filterOption: FilterOption = .name
    
    enum FilterOption{
        case name, namereversed, marketCap, marketCapReversed, price, priceReversed
    }
    
    func loadCoins(){
        Task{
            do{
                let test = try await model.fetchCoins()
                DispatchQueue.main.async {
                    self.coinListMarket = test
                }
            }
        }
    }
    
    func sortCoins(sort: FilterOption){
        switch sort{
        case .name:
            //print("in .name")
            coinListMarket.sort(by: {$0.name.lowercased() < $1.name.lowercased()})
        case .namereversed:
            //print("in .namereversed")
            coinListMarket.sort(by: {$0.name.lowercased() > $1.name.lowercased()})
        case .marketCap:
            coinListMarket.sort(by: {$0.marketCap < $1.marketCap})
        case .marketCapReversed:
            coinListMarket.sort(by: {$0.marketCap > $1.marketCap})
        case .price:
            coinListMarket.sort(by: {$0.currentPrice < $1.currentPrice})
        case .priceReversed:
            coinListMarket.sort (by: {$0.currentPrice > $1.currentPrice})
        }
    }
}

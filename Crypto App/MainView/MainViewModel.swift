//
//  CryptoViewModel.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    
    let model = MainModel()
    let background = Color(red: 0.09, green: 0.09, blue: 0.43)
    
    @Published var coinList: [Coin] = []
    @Published var filterOption: FilterOption = .name
    
    enum FilterOption{
        case name, namereversed, marketCap, marketCapReversed, price, priceReversed
    }
    
    func loadCoins() {
        Task{
            do{
                let test = try await model.fetchCoins()
                DispatchQueue.main.async {
                    self.coinList = test
                }
            }
        }
    }
    
    func sortCoins(coinList:[Coin], sort: FilterOption){
        switch sort{
        case .name:
            self.coinList.sort(by: {$0.name.lowercased() < $1.name.lowercased()})
        case .namereversed:
            self.coinList.sort(by: {$0.name.lowercased() > $1.name.lowercased()})
        case .marketCap:
            self.coinList.sort(by: {$0.marketCap < $1.marketCap})
        case .marketCapReversed:
            self.coinList.sort(by: {$0.marketCap > $1.marketCap})
        case .price:
            self.coinList.sort(by: {$0.currentPrice < $1.currentPrice})
        case .priceReversed:
            self.coinList.sort (by: {$0.currentPrice > $1.currentPrice})
        }
    }
}

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
    
    
    @Published var coinListMarket: [Coin] = []
    @Published var filterOption: FilterOption = .name
    @Published var errorText: String?
    
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
            }catch{
                DispatchQueue.main.async {
                    if let error = error as? NetworkError {
                        self.errorText = error.errDescription
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.errorText = nil
                }
            }
        }
    }
        
        func sortCoins(sort: FilterOption){
            switch sort{
            case .name:
                coinListMarket.sort(by: {$0.name.lowercased() < $1.name.lowercased()})
            case .namereversed:
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

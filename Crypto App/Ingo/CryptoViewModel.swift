//
//  CryptoViewModel.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

    
    class ViewModel: ObservableObject {
        
        @Published var coinListVM: [coin] = []
        var model = Model()
        @Published var coinListMarket: [CoinMarketElement] = []

        func loadCoins(){
            
            Task{
                do{
//                    try await model.getCoinBug()
                    
                    let test = try await model.getCoinMarket()
                    
                    DispatchQueue.main.async {
                        self.coinListMarket = test
                        
                    }
                    
                }
            }
            
            
        }
    }


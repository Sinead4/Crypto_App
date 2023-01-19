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

    
    func loadCoins(){
        
        Task{
            do{
                self.coinListVM = try await model.getCoinList()
//                self.coinListVM = try! JSONDecoder().decode([coin].self, from: data!)
                print(self.coinListVM.count)
            }
        }
        

    }
}

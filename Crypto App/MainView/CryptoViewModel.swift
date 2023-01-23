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
                let coinList = try await model.getCoinList()
                
                DispatchQueue.main.async {
                    self.coinListVM = coinList
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

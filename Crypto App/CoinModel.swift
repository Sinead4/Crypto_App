//
//  Model.swift
//  Crypto App
//
//  Created by Sinead on 22.12.22.
//

import Foundation

extension CoinListView {

    class CoinModel: ObservableObject {
        var coinList: [coin] = []
        @Published var isBusy = false
    
        
        func fetchCoins(coinURL: URL) -> Array<coin>{
            print("in fetchCoins")
            
            
            URLSession.shared.dataTask(with: coinURL){
                
                data, response,error in
                
                print("in url session")
                
                print("in task background")
                if let response = response as? HTTPURLResponse {
                    if response.statusCode >= 300 {
                        print("status grösser als 300")
                        //                        completionHandler(.failure(.httpError(response.statusCode)))
                        return
                    }
                }
                
                if let error{
                    print(error)
                    //                completionHandler(.failure(.misc(error.localizedDescription)))
                    return
                }
                
                do{
                    DispatchQueue.main.async {
                        print("in mainthread")
                        
                        self.coinList = try! JSONDecoder().decode([coin].self, from: data!)
                        print(self.coinList.count)
                        
                    }
                    
                }
   
            }.resume()
           
            setBusy(state: false)
            
            return self.coinList
            
        }
        
        func setBusy(state: Bool) {
            DispatchQueue.main.async {
                self.isBusy = state
            }
        }

        enum ModelError: Error {
            case model
            case dataService
            case error(text: String)
        }
    }
    
}

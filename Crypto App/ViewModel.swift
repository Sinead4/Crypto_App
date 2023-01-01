//
//  ViewModel.swift
//  Crypto App
//
//  Created by Sinead on 22.12.22.
//

import Foundation
import SwiftUI

extension CoinListView {
    
    class ViewModel: ObservableObject {
        @Published var posts: [DummyPingStructure] = []
        @Published var coinListVM: [coin] = []
        
        var model = CoinModel()
        let coinURL: URL
        
        init(){
            print("in init")
            coinURL = URL(string: "https://api.coingecko.com/api/v3/coins/list")!
        }
        
        func loadCoins(){
            
            URLSession.shared.dataTask(with: self.coinURL){
                data, response,error in
                
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
                        
                        self.coinListVM = try! JSONDecoder().decode([coin].self, from: data!)
                        print(self.coinListVM.count)
                        
                    }
                    
                }
            }.resume()
        }
        
        
        //        func loadCoins(completionHandler: @escaping (Result<Array<coin>, Error>) -> Void){
        //            model.setBusy(state: true)
        //            print("in loadCOins")
        //
        ////            DispatchQueue.global(qos: .background).async {
        //                print("and here")
        //            CoinModel.fetchCoins(coinURL: self.coinURL){
        //                    result in
        //
        //                    switch result{
        //                    case .success(let coinLi):
        //                        print("in success")
        //                        completionHandler(.success(self.coinListVM = coinLi))
        //
        //                    case .failure():
        //                        print("in failure")
        //                        completionHandler(.failure(Error))
        //                    }
        //
        //
        //                }
        ////                print(test.count)
        //                print("after test")
        ////            }
        //
        //
        //
        //        }
        //
        //        func setCoinList(){
        //
        //            DispatchQueue.main.async {
        //                print("schon am zuweisen")
        ////                self.coinListVM = test
        //            }
        //        }
        
    }
    
    
    
}

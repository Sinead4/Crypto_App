//
//  CoinListView2.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation
import SwiftUI

struct CoinListView: View {
    
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        VStack {
            Text("Crypto App")
            Text("is Busy?")
            
            //            if(viewModel.isBusy){
            //                Text("Ja")
            //            }else{
            //                Text("Nein")
            //            }
            
            //Search bar
            Text("Search by: ")
            
            //CryptoListe
            List(viewModel.coinListVM){ coin in
                CoinCard(coin: coin)
                Text("hi")
            }.onAppear(perform: viewModel.loadCoins)
                .padding()
        }
    }
    
    struct CoinCard: View{
        let coin: coin
        
        var body: some View{
            VStack{
                Text(coin.name)
                Text("Symbol " + coin.symbol)
                
            }
        }
        
    }
    
    // MARK: - ContentView_Previews
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            CoinListView()
        }
    }
}


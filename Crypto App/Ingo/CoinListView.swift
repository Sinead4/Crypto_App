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

            
            //Search bar
            Text("Search by: ")
            
            //CryptoListe
            List(viewModel.coinListMarket){ coin in
                CoinCard(coin: coin)
            }.onAppear(perform: viewModel.loadCoins)
                .padding()
        }
    }
    
    struct CoinCard: View{
        let coin: CoinMarketElement
        
        var body: some View{
            HStack{

                VStack{
                    Text(coin.name)
//                    Text(String(coin.currentPrice))
                }
                
                
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


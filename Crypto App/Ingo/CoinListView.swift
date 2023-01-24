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
                    .frame(      minWidth: 0,
                                 maxWidth: .infinity,
                                 minHeight: 0,
                                 maxHeight: 50,
                                 alignment: .leading)
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    
            }.onAppear(perform: viewModel.loadCoins)
                .listStyle(.inset)
                
                
        }
    }
    
    struct CoinCard: View{
        let coin: CoinMarketElement
    
        var body: some View{
            HStack{
                
                AsyncImage(url: URL(string: coin.image)){ image in
                    image.resizable()
                        .scaledToFit()
                        
                }placeholder: {
                    //test
                }
                

                
                VStack{
                    Text(coin.name)
                    Text(String(coin.symbol))
                }
                Spacer()
                VStack{
                    Text(String("$ \(coin.currentPrice)"))
                    Text(String(" \(coin.priceChangePercentage24H) %"))
                }
                
            } .cornerRadius(10)
                .padding(10)

        }
           
        
    }
    
    // MARK: - ContentView_Previews
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            CoinListView()
        }
    }
}


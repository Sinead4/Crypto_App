//
//  CoinListView2.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    
    var body: some View {
        VStack {
            Text("Crypto App") .foregroundColor(Color.white)
            
            Spacer(minLength: 25)
            
            HStack{
                HStack(spacing: 4){
                    Text("Rank")
                    Image(systemName: "chevron.down")
//                        .opacity( (viewModel.filterOption == .name || viewModel.filterOption == .namereversed ) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: viewModel.filterOption == .marketCap ? 0 : 180))
                }.onTapGesture {
                    if viewModel.filterOption == .marketCap {
                        viewModel.filterOption = .marketCapReversed
                        viewModel.sortCoins(sort: .marketCapReversed)
                    }else {
                        viewModel.filterOption = .marketCap
                        viewModel.sortCoins(sort: .marketCap)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 4){
                    Text("Name")
                    Image(systemName: "chevron.down")
//                        .opacity( (viewModel.filterOption == .name || viewModel.filterOption == .namereversed ) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: viewModel.filterOption == .name ? 0 : 180))
                }.onTapGesture {
                    if viewModel.filterOption == .name {
                        viewModel.filterOption = .namereversed
                        viewModel.sortCoins(sort: .namereversed)
                    }else {
                        viewModel.filterOption = .name
                        viewModel.sortCoins(sort: .name)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 4){
                    Text("Price")
                    Image(systemName: "chevron.down")
//                        .opacity( (viewModel.filterOption == .price || viewModel.filterOption == .priceReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: viewModel.filterOption == .price ? 0 : 180))
                }.onTapGesture {
                    if viewModel.filterOption == .price {
                        viewModel.filterOption = .priceReversed
                        viewModel.sortCoins(sort: .priceReversed)
                    }else {
                        viewModel.filterOption = .price
                        viewModel.sortCoins(sort: .price)
                    }
                }
            } .foregroundColor(Color.white)
                .font(.system(size: 14))
            
                
            
            
            //CryptoListe
            List(viewModel.coinListMarket){ coin in
                NavigationLink(destination: DetailView(coin: coin), label: {
                    CoinCard(coin: coin)
                        .frame(      minWidth: 0,
                                     maxWidth: .infinity,
                                     minHeight: 0,
                                     maxHeight: 50,
                                     alignment: .leading)
                        .background(Color.theme.background)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                                                
                })
                
            }.onAppear(perform: viewModel.loadCoins)
                .background(Color.theme.background)
                .listStyle(PlainListStyle())
            
            
        }.background(Color.theme.background)
    }
    
    struct CoinCard: View{
        let coin: Coin
        
        var body: some View{
            HStack(spacing: 0){
                Text(String(format: "%.0f", coin.marketCapRank))
                    .frame(minWidth: 30)
                
                AsyncImage(url: URL(string: coin.image)){ image in
                    image.resizable()
                        .scaledToFit()
                    
                }placeholder: {
                    //test
                }
                
                VStack(alignment: .leading){
                    Text(coin.name)
                    Text(String(coin.symbol.uppercased()))
                }.padding(.leading, 16)
                
                Spacer()
                
                VStack(alignment: .trailing){
                    HStack{
                        Text("$")
                        Text(String(format: "%.2f",coin.currentPrice)).bold()
                    }
                    HStack{
                        Text("$")
                        Text(String(format: "%.2f",coin.priceChangePercentage24H))
                    }

                }
                
            } .cornerRadius(10)
                .padding(10)
               

            
        }
        
        
    }
    
    // MARK: - ContentView_Previews
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
}


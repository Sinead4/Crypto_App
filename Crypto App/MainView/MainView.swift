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
    @ObservedObject var network = NetworkMonitor()
    
    var body: some View {
        VStack {
            
            if($network.isNotConnected.wrappedValue){
                ZStack{
                    Text("No internet connection").foregroundColor(Color.black)
                }.alert(isPresented: $network.isNotConnected){
                    Alert(title: Text("No Internet Connection"),
                          primaryButton: .default(Text("Retry")){
                        viewModel.loadCoins()
                    },
                          secondaryButton: .destructive(Text("Dissmiss")))
                }
            }
            
            FilterOptions().environmentObject(viewModel)
            CryptoList().environmentObject(viewModel)
            
        }.background(Color.theme.background)
            .navigationTitle("Market")
    }
                
}


struct FilterOptions: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            FilterOptionItem(text: "Rank", filterOption: MainViewModel.FilterOption.marketCap, onTapGesture: {
                
                if viewModel.filterOption == .marketCap {
                    viewModel.filterOption = .marketCapReversed
                    viewModel.sortCoins(sort: .marketCapReversed)
                }else {
                    viewModel.filterOption = .marketCap
                    viewModel.sortCoins(sort: .marketCap)
                }
            })
            
            Spacer()
            
            FilterOptionItem(text: "Name", filterOption: MainViewModel.FilterOption.name, onTapGesture: {
                
                if viewModel.filterOption == .name {
                    viewModel.filterOption = .namereversed
                    viewModel.sortCoins(sort: .namereversed)
                }else {
                    viewModel.filterOption = .name
                    viewModel.sortCoins(sort: .name)
                }
            })
            
            Spacer()
            
            FilterOptionItem(text: "Price", filterOption: MainViewModel.FilterOption.price, onTapGesture: {
                
                if viewModel.filterOption == .price {
                    viewModel.filterOption = .priceReversed
                    viewModel.sortCoins(sort: .priceReversed)
                }else {
                    viewModel.filterOption = .price
                    viewModel.sortCoins(sort: .price)
                }
            })
        }.padding()
    }
}

struct FilterOptionItem: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var text: String
    var filterOption: MainViewModel.FilterOption
    var onTapGesture: () -> ()
    
    var body: some View {
        HStack {
            Text(text)
            Image(systemName: "chevron.down")
                .rotationEffect(Angle(degrees: viewModel.filterOption == filterOption ? 0 : 180))
        }.onTapGesture {
            onTapGesture()
        }
    }
}

struct CryptoList: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        List(viewModel.coinList){ coin in
            NavigationLink(destination: DetailView(coin: coin),
                           label: { CoinCard(coin: coin).frame(maxHeight: 50)}).listRowBackground(Color.theme.background)
        }.onAppear(perform: viewModel.loadCoins)
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
    }
}

struct CoinCard: View{
    let coin: Coin
    
    var body: some View{
        HStack{
            HStack {
                Text(String(format: "%.0f", coin.marketCapRank)).padding(.trailing)
                AsyncImage(url: URL(string: coin.image)){ image in
                    image.resizable().frame(width: 30, height: 30)
                }placeholder: {}
                VStack(alignment: .leading){
                    Text(coin.name)
                    Text(String(coin.symbol.uppercased())).font(.caption).foregroundColor(Color.gray)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing){
                Text(String(format: "%.2f",coin.currentPrice) + " $").bold()
                Text(String(format: "%.2f",coin.priceChangePercentage24H) + " %").foregroundColor(Color.pink)
            }
        }
    }
}

// MARK: - ContentView_Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

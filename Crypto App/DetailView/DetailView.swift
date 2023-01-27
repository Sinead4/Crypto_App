//
//  DetailView.swift
//  Crypto App
//
//  Created by Jan Wälti on 23.01.23.
//

import SwiftUI
import Charts
import Foundation

struct DetailView: View {
    @State var coin: Coin
    @State var chosenTimeInterval: TimeInterval = .oneYear
    
    @ObservedObject var detailVM: DetailViewModel = DetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack() {
                //Text(String(detailVM.fetchedPrices.prices.count))
                /*
                 Button {
                 timeFrame = timeFrame - 10
                 Task {
                 try await detailVM.loadPrices(id: coin.id, currency: "usd", days: timeFrame)
                 }
                 } label: {
                 Text("test")
                 }
                 */
                //Text(String($chosenTimeInterval.rawValue))
                GraphView(coin: $coin, chartItems: $detailVM.priceChartItems)
                PickerView(coin: $coin, chosenTimeInterval: $chosenTimeInterval).environmentObject(detailVM)
                TableView(coin: $coin)
            }
        }.onAppear {
            //chosenTimeInterval = .oneDay
            
            Task {
                try await detailVM.loadPrices(id: coin.id, currency: "usd", days: chosenTimeInterval.rawValue)
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(coin.name).bold().font(.title)
                    AsyncImage(url: URL(string: coin.image)){ image in
                        image.resizable().frame(width: 30, height: 30)
                    } placeholder: {}
                }
            }
        }
    }
}

struct GraphView : View {
    @Binding var coin: Coin
    @Binding var chartItems: [ChartPrice]
    
    var gradient = LinearGradient(gradient: Gradient(colors: [.pink, .clear]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        Chart(chartItems) { item in
            AreaMark(
                x: .value("X Achse", item.date),
                y: .value("Y Achse", item.price)
            )
            .interpolationMethod(.cardinal)
            .foregroundStyle(gradient)
            LineMark(
                x: .value("X Achse", item.date),
                y: .value("Y Achse", item.price)
            )
            .interpolationMethod(.cardinal)
            .lineStyle(StrokeStyle(lineWidth: 1))
            .foregroundStyle(Color.pink)
        }.frame(height: 200).padding()
    }
}

struct PickerView: View {
    @Binding var coin: Coin
    @Binding var chosenTimeInterval : TimeInterval
    @EnvironmentObject var detailVM: DetailViewModel
    
    var body: some View {
        Picker("", selection: $chosenTimeInterval) {
            ForEach(TimeInterval.allCases, id: \.self) { option in
                Text(option.label)
            }
        }.pickerStyle(SegmentedPickerStyle()).padding()
            .onTapGesture {
                // TODO - FIX
                //chosenTimeInterval = $chosenTimeInterval.wrappedValue
                Task {
                    try await detailVM.loadPrices(id: coin.id, currency: "usd", days: chosenTimeInterval.rawValue)
                }
            }
    }
}

struct TableView: View {
    @Binding var coin: Coin
    
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    private let spacing: CGFloat = 30
    
    var body: some View {
        VStack(spacing: 20) {
            overviewTitle
            Divider()
            overviewGrid
            detailsTitle
            Divider()
            detailsGrid
        }.padding()
    }
}

struct DetailsItem: View {
    var text: String
    var value: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(text).font(.caption).foregroundColor(Color.gray)
            Spacer()
            Text(value).bold()
        }
    }
}

extension TableView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var detailsTitle: some View {
        Text("Details ")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  content: {
            DetailsItem(text: "Price", value: "$ " + String(coin.currentPrice))
            DetailsItem(text: "Market Cap", value: "$ " + String(Int(coin.marketCap)))
            DetailsItem(text: "Rank", value: String(Int(coin.marketCapRank)))
            DetailsItem(text: "Volume", value: String(Int(coin.totalVolume)))
        })
    }
    
    private var detailsGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  content: {
            DetailsItem(text: "24h High", value: "$ " + String(coin.high24H))
            DetailsItem(text: "24h Low", value: "$ " + String(coin.low24H))
            DetailsItem(text: "24h Change", value: String(format:"%.2f", coin.priceChangePercentage24H) + " %")
            DetailsItem(text: "Available Supply:", value: String(Int(coin.circulatingSupply ?? 0.0)))
        })
    }
}

// MARK: - Preview


/*
 struct DetailView_Previews: PreviewProvider {
 static var previews: some View {
 
 DetailView(coin: .constant(Coin(id: "asdf", symbol: "asf", name: "sdf", image: "sdfgs", currentPrice: 4.3, marketCap: 2.3, marketCapRank: 6.4, totalVolume: 4.3, high24H: 4.3, low24H: 4.3, priceChange24H: 43.3, priceChangePercentage24H: 4.3, marketCapChange24H: 4.3, marketCapChangePercentage24H: 6.4, ath: 7.6, athChangePercentage: 3.5, athDate: "asd", atl: 5.3, atlChangePercentage: 3.3, atlDate: "4adf", lastUpdated: "asdf")))
 }
 }
 */

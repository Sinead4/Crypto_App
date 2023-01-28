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
    @State var isLoading: Bool = true
    @State var coin: Coin
    @State var timeInterval: Int = 1
    
    @ObservedObject var detailVM: DetailViewModel = DetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text(String(timeInterval))
                GraphView(coin: $coin, chartItems: $detailVM.priceChartItems, isLoading: $isLoading)
                PickerView(coin: $coin, timeInterval: $timeInterval).environmentObject(detailVM)
                TableView(coin: $coin)
            }
        }.onAppear {
            isLoading = true
            Task {
                try await detailVM.loadPrices(id: coin.id, currency: "usd", days: timeInterval)
                isLoading = false
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
        .background(Color.theme.background)
    }
}

struct GraphView : View {
    @Binding var coin: Coin
    @Binding var chartItems: [ChartPrice]
    @Binding var isLoading: Bool
    
    var gradient = LinearGradient(gradient: Gradient(colors: [.pink, .clear]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                Chart(chartItems) { item in
                    AreaMark(
                        x: .value("X Achse", item.date),
                        y: .value("Y Achse", item.price)
                    )
                    .foregroundStyle(gradient)
                    LineMark(
                        x: .value("X Achse", item.date),
                        y: .value("Y Achse", item.price)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 1))
                    .foregroundStyle(Color.pink)
                }
            }
        }.frame(height: 300).padding()
    }
}

struct PickerView: View {
    @Binding var coin: Coin
    @State var chosenTimeInterval: TimeInterval = .oneMonth
    //@Binding var chosenTimeInterval : TimeInterval
    @Binding var timeInterval: Int
    @EnvironmentObject var detailVM: DetailViewModel
    
    var body: some View {
        Picker("", selection: $chosenTimeInterval) {
            ForEach(TimeInterval.allCases, id: \.self) { chosenInterval in
                Text(chosenInterval.label)
            }
        }.onReceive([self.chosenTimeInterval].publisher.first()) { (chosenInterval) in
            print(String(chosenInterval.rawValue))
            timeInterval = chosenInterval.rawValue
            
            
            /*
             Task {
             try await detailVM.loadPrices(id: coin.id, currency: "usd", days: timeInterval)
             }
             
             */
        }
        .pickerStyle(SegmentedPickerStyle()).padding()
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
            DetailsItem(text: "Price", value: String(coin.currentPrice) + " $")
            DetailsItem(text: "Market Cap", value: String(Int(coin.marketCap)) + " $")
            DetailsItem(text: "Rank", value: String(Int(coin.marketCapRank)))
            DetailsItem(text: "Volume", value: String(Int(coin.totalVolume)))
        })
    }
    
    private var detailsGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  content: {
            DetailsItem(text: "24h High", value: String(coin.high24H) + " $")
            DetailsItem(text: "24h Low", value: String(coin.low24H) + " $")
            DetailsItem(text: "24h Change", value: String(format:"%.2f", coin.priceChangePercentage24H) + " %")
            DetailsItem(text: "24h Change", value: String(format:"%.2f", coin.priceChange24H) + " $")
        })
    }
}

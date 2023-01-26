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
    @State var prices: Prices = Prices(prices: [], marketCaps: [], totalVolumes: [])
    @State var timeFrame: Int = 90
    
    let model = DetailModel()

    
    @ObservedObject var detailVM: DetailViewModel = DetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack() {
                Text(String(prices.prices.count))
                Button {
                   timeFrame = timeFrame - 10
                    Task {
                        do {
                            let prices = try await model.fetchPrices(id: coin.id, currency: "usd", days: timeFrame)
                            DispatchQueue.main.async{
                                //print(prices.prices.count)
                                self.prices = prices
                                detailVM.convertPricesToPriceItem(prices: prices)
                                //print(detailVM.priceItems[0].price)
                            }
                        } catch {
                            
                        }
                    }
                    
                } label: {
                    Text("test")
                }

                
                GraphView(coin: $coin, chartItems: $detailVM.priceItems)
                PickerView()
                TableView(coin: $coin)
            }
        }.onAppear {
            timeFrame = 90
            // TODO detailsVM verwenden
            Task {
                do {
                    let prices = try await model.fetchPrices(id: coin.id, currency: "usd", days: timeFrame)
                    DispatchQueue.main.async{
                        //print(prices.prices.count)
                        self.prices = prices
                        detailVM.convertPricesToPriceItem(prices: prices)
                        //print(detailVM.priceItems[0].price)
                    }
                } catch {
                    
                }
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
    //var detailVM: DetailViewModel
    @Binding var coin: Coin
    @Binding var chartItems: [PriceItem]
    
    var body: some View {
        Chart(chartItems) { item in
            AreaMark(
                x: .value("X Achse", item.date),
                y: .value("Y Achse", item.price)
            ).foregroundStyle(Color.red.gradient)
        }.frame(height: 200).padding()
            .onAppear {
                print(chartItems)
            }
        
        //Text(String(detailVM.fetchedPrices.prices.count))
    }
}

struct PickerView: View {
    @State var chosenTimeInterval : TimeInterval = .oneDay
    
    var body: some View {
        Picker("", selection: $chosenTimeInterval) {
            ForEach(TimeInterval.allCases, id: \.self) { option in
                Text(option.rawValue)
            }
        }.pickerStyle(SegmentedPickerStyle()).padding()
    }
}

struct TableView: View {
    @Binding var coin: Coin
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
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

// MARK: - Mock Data
let items: [PriceItem] = [
    PriceItem(price: 10.0, value: 1674550374910),
    PriceItem(price:  11.0, value:  1674550519050),
    PriceItem(price:   12.0, value: 1674550934095),
    PriceItem(price:  13.0, value: 1674551127192),
]

let specs: [Spec] = [
    Spec(title: "Market Cap Rank:", value: "1"),
    Spec(title: "Market Cap:", value: "$809434"),
    Spec(title: "Price:", value: "$8434"),
]

struct Spec: Identifiable {
    var id = UUID()
    let title: String
    let value: String
}


enum TimeInterval : String, CaseIterable {
    case oneDay = "1D"
    case oneWeek = "7D"
    case oneMonth = "1M"
    case threeMonths = "3M"
    case oneYear = "1Y"
    case twoYears = "2Y"
    case fiveYears = "5Y"
}

// MARK: - Preview


/*
 struct DetailView_Previews: PreviewProvider {
 static var previews: some View {
 
 DetailView(coin: .constant(Coin(id: "asdf", symbol: "asf", name: "sdf", image: "sdfgs", currentPrice: 4.3, marketCap: 2.3, marketCapRank: 6.4, totalVolume: 4.3, high24H: 4.3, low24H: 4.3, priceChange24H: 43.3, priceChangePercentage24H: 4.3, marketCapChange24H: 4.3, marketCapChangePercentage24H: 6.4, ath: 7.6, athChangePercentage: 3.5, athDate: "asd", atl: 5.3, atlChangePercentage: 3.3, atlDate: "4adf", lastUpdated: "asdf")))
 }
 }
 */

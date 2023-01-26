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
    
    var coin: Coin
    
    @StateObject private var detailVM: DetailViewModel
    
    init(coin: Coin) {
        self.coin = coin
        _detailVM = StateObject(wrappedValue: DetailViewModel(id: coin.id, currency: "usd", days: 1))
    }
    
    var body: some View {
        ScrollView {
            VStack() {
                GraphView(detailVM: detailVM, coin: coin)
                PickerView()
                TableView(coin: coin)
            }
        }.navigationBarTitle(coin.name, displayMode: .large)
    }
}

struct GraphView : View {
    var detailVM: DetailViewModel
    var coin: Coin
    var body: some View {
        Chart(detailVM.priceItems) { priceItem in
            AreaMark(
                x: .value("X Achse", priceItem.dateAsString),
                y: .value("Y Achse", priceItem.value)
            ).foregroundStyle(Color.red.gradient)
        }.frame(height: 200).padding()
        
        Text(String(detailVM.prices.prices.count))
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
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    var coin: Coin
    var body: some View {
        VStack(spacing: 20) {
            overViewTitle
            Divider()
            overViewGrid
            additionalTitle
            Divider()
            additionalGrid
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
    private var overViewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details ")
            .font(.title)
            .bold()
            .foregroundColor(Color.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overViewGrid: some View {
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
    
    private var additionalGrid: some View {
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
    PriceItem(price: 1674550374910, value: 23063.901776933366),
    PriceItem(price:  1674550519050, value:  23074.660478399),
    PriceItem(price: 1674550934095, value:   23054.641168848542),
    PriceItem(price: 1674551127192, value:  22985.47603666547),
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
 DetailView()
 }
 }
 */

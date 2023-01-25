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

    @StateObject var detailVM = DetailViewModel()
    
    var body: some View {
        VStack() {
            //Debug
            Button(action: {detailVM.loadPrices(id: coin.id, from: 1674550000, to: 1674570012)}) {
                Text("Test")
            }
            
            GraphView(detailVM: detailVM, coin: coin)
            PickerView()
            TableView(coin: coin)
        }.navigationTitle(coin.name)
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
    var coin: Coin
    var body: some View {
        List {
            TableItem(text: "Market Cap Rank:", value: String(Int(coin.marketCapRank)))
            TableItem(text: "Market Cap:", value: "$ " + String(coin.marketCap))
            TableItem(text: "Price:", value: "$ " + String(coin.currentPrice))
            TableItem(text: "Available Supply:", value: String(Int(coin.circulatingSupply ?? 0.0)))
            TableItem(text: "Total Supply:", value: String(Int(coin.totalSupply ?? 0)))
            TableItem(text: "24H High:", value: "$ " + String(coin.high24H))
            TableItem(text: "24H Low:", value: "$ " + String(coin.low24H))
            TableItem(text: "24H Change:", value: String(format:"%.2f", coin.priceChangePercentage24H) + " %")
        }
        .listStyle(.inset)
    }
}

struct TableItem: View {
    var text: String
    var value: String
    var body: some View {
        HStack() {
            Text(text)
            Spacer()
            Text(value)
        }
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

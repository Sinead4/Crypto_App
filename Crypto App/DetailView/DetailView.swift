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
    
    let coin: CoinMarketElement
    
    @StateObject var detailVM = DetailViewModel()
    
    var body: some View {
        VStack() {
            GraphView()
            PickerView()
            TableView()
            Text(coin.name)
        }
    }
}

struct GraphView : View {
    var body: some View {
        Chart(items) { item in
            AreaMark(
                x: .value("X Achse", item.dateAsString),
                y: .value("Y Achse", item.value)
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
    var body: some View {
        List {
            ForEach(specs) { spec in
                TableItem(spec: spec)
            }
        }.listStyle(.inset)
    }
}

struct TableItem: View {
    var spec: Spec
    var body: some View {
        HStack() {
            Text(spec.title)
            Spacer()
            Text(spec.value)
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

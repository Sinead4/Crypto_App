//
//  Crypto_AppApp.swift
//  Crypto App
//
//  Created by Sinead on 14.12.22.
//

import SwiftUI

@main
struct CryptoApp: App {
    
//    let networkMonitor = NetworkMonitor.shared
//
//    init() {
//        networkMonitor.start()
//    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            }
        }
    }
}

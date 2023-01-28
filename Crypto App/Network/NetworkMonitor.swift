//
//  NetworkMonitor.swift
//  Crypto App
//
//  Created by Sinead on 26.01.23.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject{
    
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor ()
    private let queue = DispatchQueue.global(qos: .background)
    @Published public var isNotConnected = false
    
    init(){
        monitor.pathUpdateHandler = {path in
            DispatchQueue.main.async{
                self.isNotConnected = path.status == .unsatisfied
                print(self.isNotConnected)
            }
        }
            
        monitor.start(queue: queue)
    }
    
    func start(){
        
        monitor.pathUpdateHandler = {path in
            DispatchQueue.main.async{
                self.isNotConnected = path.status == .satisfied
                print(self.isNotConnected)
            }
            
            
//            Task{
//                await MainActor.run{
//                    self.objectWillChange.send()
//                }
//            }
        }
        
        monitor.start(queue: queue)
    }
    
    func stop(){
        monitor.cancel()
    }
    
//    func checkInternet() {
//                monitor.pathUpdateHandler = { path in
//              if path.status == .satisfied {
//                    print("Internet connection is on.")
//
//              }
//                    else {
//                    self.showAlert = true
//
//                }
//
//            }
//
//        let queue = DispatchQueue(label: "Monitor")
//                monitor.start(queue: queue)
//                
//            }
}

import SwiftUI
import Network

struct ContentView: View {
    
    @State private var showAlert = false
    private var monitor = NWPathMonitor()
    
    var body: some View {
        Button("Check internet") {
            self.checkInternet()
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("No internet connection"),
                  message: Text("Please check your internet connection and try again"),
                  dismissButton: .default(Text("OK")))
            
        }
        
    }
    
    func checkInternet() {
                monitor.pathUpdateHandler = { path in
              if path.status == .satisfied {
                    print("Internet connection is on.")
                  
              }
                    else {
                    self.showAlert = true
                    
                }
                
            }
        
        let queue = DispatchQueue(label: "Monitor")
                monitor.start(queue: queue)
                
            } }

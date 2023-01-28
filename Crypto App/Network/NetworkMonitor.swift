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
        }
        monitor.start(queue: queue)
    }
    
    func stop(){
        monitor.cancel()
    }
}


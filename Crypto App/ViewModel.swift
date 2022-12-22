//
//  ViewModel.swift
//  Crypto App
//
//  Created by Sinead on 22.12.22.
//

import Foundation

extension ContentView {
    
    class ViewModel: ObservableObject {
        @Published var posts: [DummyPostStructure] = []
        
        var model = Model()
        
        func setDataService(_ dataService: DataServiceProtocol) {
            model.dataService = dataService
        }
        
        func reload() {
            model.fetch { [self] result in
                switch result {
                case .success():
                    // Add model data to vm data
                    DispatchQueue.main.async {
                        self.posts = self.model.result.map { $0 }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

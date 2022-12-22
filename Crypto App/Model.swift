//
//  Model.swift
//  Crypto App
//
//  Created by Sinead on 22.12.22.
//

import Foundation

extension ContentView {

    class Model {
        var dataService: DataServiceProtocol?
        
        var result: [DummyPostStructure] = []


        func fetch(completionHandler: @escaping (Result<Void, ModelError>) -> Void) {
            guard let dataService else {
                completionHandler(.failure(.dataService))
                return
            }

            dataService.load(from: TemplateEndPoints.posts, convertTo: [DummyPostStructure].self) { result in

                switch result {
                case .success(let posts):
                    self.result = posts
                    completionHandler(.success(()))
                case .failure(let error):
                    completionHandler(.failure(.error(text: error.localizedDescription)))
                }
            }
            
        }


        enum ModelError: Error {
            case model
            case dataService
            case error(text: String)
        }
    }
    
}

//
//  Service.swift
//  Crypto App
//
//  Created by Sinead on 22.12.22.
//

//from ingo
import Foundation

enum NetworkError: Error {
    case decoding
    case internet
    case noData
    case httpError(Int)
    case misc(String)
}

// MARK: - TemplateEndPoints

enum CryptoEndPoints: String {
    case ping = "https://api.coingecko.com/api/v3//ping"
    case getAllCoins = "https://api.coingecko.com/api/v3/coins/list"
    


}

extension CryptoEndPoints { // API URLs
    private var host: URL {
        print("in EndPoints host")
        guard let url = URL(string: "https://api.coingecko.com/api/v3/") else {
            fatalError("URL Is Invalid")
        }
        return url
    }
    
    var url: URL {
        return self.host.appending(path: self.rawValue)
    }
    
    func url(id: Int) -> URL {
        let url = self.url
        return url.appending(path: "/\(id)")
    }
    
    var method: String {
        switch self {
        case .getAllCoins: return "GET"
        default: return "POST"
        }
    }
    
    //    var request: URLRequest {
    //        var request = URLRequest(url: url)
    //        request.httpMethod = self.method
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //
    //        return request
    //    }
    //
    //    func request(for queryData: Encodable?) -> URLRequest {
    //        var request = self.request
    //        if let queryData {
    //            request.httpBody = try? JSONEncoder().encode(queryData)
    //        }
    //        return request
    //    }
    
}


    



extension CoinListView {
    
    class DataService{
        let coinUrl: URL
        let apiRequest: Any
        
        init() {
            self.coinUrl = URL(string: "https://api.coingecko.com/api/v3/coins/list")!

            self.apiRequest = URLSession.shared.dataTask(with: coinUrl){
                data, response,error in
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode >= 300 {
                        print("status grösser als 300")
                        //                        completionHandler(.failure(.httpError(response.statusCode)))
                        return
                    }
                }
                
                if let error{
                    print(error)
                    //                completionHandler(.failure(.misc(error.localizedDescription)))
                    return
                }
                
                
                
            }
        }
        
//        func fetchCoinData<T: Decodable>(
//            convertTo type: T.Type,
//            completionHandler: @escaping (Result<T, NetworkError>) -> Void)
//        {
//            print("in fetchData")
//
//            URLSession.shared.dataTask(with: coinUrl) { data, response, error in
//                if let response = response as? HTTPURLResponse {
//                    if response.statusCode >= 300 {
//                        completionHandler(.failure(.httpError(response.statusCode)))
//                        return
//                    }
//                }
//
//                if let error {
//                    completionHandler(.failure(.misc(error.localizedDescription)))
//                    return
//                }
//
//                guard let data else {
//                    completionHandler(.failure(.noData))
//                    return
//                }
//
//                do {
//                    let result = try JSONDecoder().decode(T.self, from: data)
//                    completionHandler(.success(result))
//                } catch {
//                    JSONDecoder.testForDecodableError(T.self, from: data)
//                    completionHandler(.failure(.misc(error.localizedDescription)))
//                }
//            }
//            .resume()
//        }
        
    }
    
    
    // MARK: - MockService
    
    class MockService: GenericDataService, DataServiceProtocol {
        
        func load<T>(from endpoint: EndpointProtocol, convertTo type: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
            
            load(from: endpoint.mockUrl, convertTo: type, completion: completion)

        }
    }
    
    // MARK: - NetworkService
    
    class NetworkService: GenericDataService, DataServiceProtocol {
        
        func load<T>(from endpoint: EndpointProtocol, convertTo type: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {

            load(from: endpoint.url, convertTo: type, completion: completion)

        }
        
    }
    


}


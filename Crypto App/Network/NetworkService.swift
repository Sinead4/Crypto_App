//
//  NetworkService.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation


protocol DataService {
     static func load<T: Decodable>(
        from request: URLRequest,
        convertTo type: T.Type) async throws -> T

}

class NetworkService: DataService {
    
//    static func loadCoinsBug<T: Decodable>(
//        from request: URLRequest,
//        convertTo type: T.Type) async throws
//    {
//        print("in load")
//        let (data, response) = try await URLSession.shared.data(for: request)
//        print("data ist: \(data.description)")
//        print("response ist: \(response)")
//
//        if let httpResponse = response as? HTTPURLResponse,
//           httpResponse.statusCode >= 300 {
//            print("httpResponse ist: \(httpResponse)")
//            throw NetworkError.httpError(httpResponse.statusCode)
//        }
//
//        print("hello here")
//
//        let decodedData: T
//
//        do{
//            decodedData = try JSONDecoder().decode(T.self, from: data)
//
//            print("decodededata is now: \(decodedData)")
//        }catch{
//            print(error)
//        }
//
//    }
    
    static func loadCoins<T: Decodable>(
        from request: URLRequest,
        convertTo type: T.Type) async throws ->T
    {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode >= 300 {
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        let decodedData = try JSONDecoder().decode(T.self, from: data)
           
        print("decodededata is now: \(decodedData)")

        return decodedData
    }
    
    
    static func load<T: Decodable>(
        from request: URLRequest,
        convertTo type: T.Type) async throws -> T
    {
        let (data, response) = try await URLSession.shared.data(for: request)

        
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode >= 300 {
            throw NetworkError.httpError(httpResponse.statusCode)
        }

        let decodedData = try JSONDecoder().decode(T.self, from: data)

        return decodedData
        
    }

}

// MARK: - MockService

class MockService: DataService {
    static func load<T>(from request: URLRequest, convertTo type: T.Type) async throws -> T where T : Decodable {
        
        guard let fileName = request.url?.lastPathComponent,
              let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json")
        else{
            throw NetworkError.noData
        }
        
        let data = try Data(contentsOf: fileUrl)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        return decodedData
        
    }
}

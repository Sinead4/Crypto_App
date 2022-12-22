//
//  misc.swift
//  Crypto App
//
//  Created by Sinead on 22.12.22.
//

//from Ingo dies file
import Foundation

// MARK: - EndpointProtocol

protocol EndpointProtocol {
    var url: URL { get }
    var mockUrl: URL { get }
}

// MARK: - DataServiceProtocol

protocol DataServiceProtocol {

    func load<T: Decodable>(
        from endpoint: EndpointProtocol,
        convertTo type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

// MARK: - GenericDataService

// MARK: - NetworkError

enum DataServiceError: Error {
    case noData
    case decoding
}


class GenericDataService {

    func load<T>(from url: URL, convertTo type: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(DataServiceError.noData))
                return
            }
            
            guard let decodedData = try? JSONDecoder().decode(type.self, from: data) else {
                // zum Debugging
                JSONDecoder.testForDecodableError(type.self, from: data)
                completion(.failure(DataServiceError.decoding))
                return
            }
            
            completion(.success(decodedData))
        }
        .resume()
    }

}

// MARK: - EXTENSIONS -

// MARK: - JSONDecoder

extension JSONDecoder {
    static func testForDecodableError<T>(_ type: T.Type, from data: Data) where T: Decodable {
        let decoder = JSONDecoder()
        do {
            let modelData = try decoder.decode(T.self, from: data)
            print(modelData)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - String + LocalizedError

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

// MARK: - Filemanager

extension FileManager {
    static var documentUrl: URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
        else {
            fatalError("Documents folder not found")
        }
        return url
    }

    static func documentUrl(for fileName: String) throws -> URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
        else {
            throw "Destination document folder not found"
        }
        return url.appending(component: "\(fileName).json")
    }

    static func copyToDocuments(fileName: String, always: Bool = true) throws {
        guard let source = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            throw "Source \(fileName) doesnt exist in the bundle"
        }
        guard var destination = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
        else {
            throw "Destination document folder not found"
        }
        destination = destination.appending(component: fileName)
        if always {
            try? FileManager.default.removeItem(at: destination.absoluteURL)
        }

        if !FileManager.default.fileExists(atPath: destination.absoluteString) {
            try FileManager.default.copyItem(at: source, to: destination)
        }
    }
}

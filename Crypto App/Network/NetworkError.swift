//
//  NetworkError.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: LocalizedError {
    case decoding
    case internet
    case noData
    case httpError(Int)
    case misc(String)
    
    
    var errDescription: String {
        switch self {
        case .decoding: return "Decoding error"
        case .internet: return "Internet connection error"
        case .noData: return "delivered data is empty"
        case .httpError(let status): return "HTTP Error Code \(status)"
        case .misc(let text): return "MISC ERROR: \(text)"
        }
    }
}

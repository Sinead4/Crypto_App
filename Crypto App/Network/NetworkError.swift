//
//  NetworkError.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: Error {
    case decoding
    case internet
    case noData
    case httpError(Int)
    case misc(String)
}

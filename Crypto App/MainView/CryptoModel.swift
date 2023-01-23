//
//  CryptoModel.swift
//  Crypto App
//
//  Created by Sinead on 19.01.23.
//

import Foundation

class Model {
    
    
    func getCoinList() async throws -> [coin]{
        let result = try await CryptoService.getCoinList()
        
        return result
        
    }
    

}

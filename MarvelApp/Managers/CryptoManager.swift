//
//  CryptoManager.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 26/12/20.
//

import Foundation
import CryptoKit

class CryptoManager {
    
    // MARK: - Public API
    
    static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}

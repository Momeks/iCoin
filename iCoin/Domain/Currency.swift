//
//  Currency.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation

enum Currency: String {
    case usd
    case euro = "eur"
    case pound = "gbp"
    
    var id: String {
        return self.rawValue
    }
    
    var flag: String {
        switch self {
        case .usd:
            return "united-states"
        case .euro:
            return "european-union"
        case .pound:
            return "united-kingdom"
        }
    }
    
    var description: String {
        switch self {
        case .usd:
            return "United States Dollar"
        case .euro:
            return "Euro"
        case .pound:
            return "Great Britain Pound"
        }
    }
}

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
            return "🇺🇸"
        case .euro:
            return "🇪🇺"
        case .pound:
            return "🇬🇧"
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

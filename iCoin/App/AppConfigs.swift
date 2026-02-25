//
//  AppConfigs.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation

struct AppConfigs {
    
    /// Base URL for CoinGecko API requests
    static let coinGeckoBaseURL = URL(string: "https://api.coingecko.com/api/v3")!
    
    /// API key for CoinGecko requests
    static let coinGeckoAPIKey: String = {
        let keyBytes: [UInt8] = [113, 119, 67, 31, 125, 4, 93, 70, 23, 31, 104, 3, 91,
                                 118, 6, 10, 87, 39, 6, 116, 0, 48, 1, 10, 65, 98, 35]
        return QrdlWPgAD4V0cSHcjTWvCQ.shared.wsM03n0ifeFVaSF1kvquZw(key: keyBytes)
    }()
    
    /// Default cryptocurrency displayed on first launch
    static let defaultCoin: String = Cryptocurrency.bitcoin.id
    
    /// Default currency used to display market prices
    static let defaultCurrency: String = Currency.usd.id
}

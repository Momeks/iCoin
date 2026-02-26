//
//  CoinDTO.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import SwiftUI

struct CoinDTO {
    let name: String
    let symbol: String
    let imageUrl: URL?
    let priceText: String
    let priceChangeText: String
    let priceChangeColor: Color
    let lastUpdatedText: String
}

#if DEBUG
extension CoinDTO {
    static var sample: CoinDTO {
        CoinDTO(
            name: "Bitcoin",
            symbol: "BTC",
            imageUrl: URL(string: "https://assets.coingecko.com/coins/images/1/small/bitcoin.png"),
            priceText: "$62,842.56",
            priceChangeText: "+192.80 (0.21%)",
            priceChangeColor: .green,
            lastUpdatedText: "May 5, 2025 at 3:12 PM"
        )
    }
}
#endif

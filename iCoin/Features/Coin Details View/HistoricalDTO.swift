//
//  HistoricalDTO.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import SwiftUI

struct HistoricalDTO {
    let name: String
    let symbol: String
    let pricesByCurrency: [Currency: String]
}

#if DEBUG
extension HistoricalDTO {
    static let sample = HistoricalDTO(
        name: "Bitcoin",
        symbol: "BTC",
        pricesByCurrency: [
            .usd: "$93,605.45",
            .euro: "€82,601.29",
            .pound: "£73,300.00"
        ]
    )
}
#endif


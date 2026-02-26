//
//  MarketChartDTO.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import CoinKit

struct MarketChartDTO: Identifiable {
    var id: TimeInterval { date.timeIntervalSince1970 }
    let date: Date
    let priceText: String
}

#if DEBUG
extension MarketChartDTO {
    static let sample = MarketChartDTO(
        date: Calendar.current.date(from: DateComponents(year: 2026, month: 2, day: 26)) ?? Date(),
        priceText: "$72,134.54"
    )
    
    static let sampleList: [MarketChartDTO] = HistoricalPrice.sampleList.map {
        MarketChartDTO(
            date: $0.date,
            priceText: $0.price.formatted(.currency(code: AppConfigs.defaultCurrency.uppercased()))
        )
    }
}
#endif

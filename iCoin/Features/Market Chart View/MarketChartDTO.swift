//
//  MarketChartDTO.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import CoinKit

struct MarketChartDTO: Identifiable {
    let id = UUID()
    let dateText: String
    let priceText: String
}

#if DEBUG
extension MarketChartDTO {
    static let sample = MarketChartDTO(
        dateText: "Apr 24, 2024",
        priceText: "$72,134.54"
    )
    
    static let sampleList: [MarketChartDTO] = HistoricalPrice.sampleList.map {
        MarketChartDTO(
            dateText: $0.date.formatted(date: .abbreviated, time: .omitted),
            priceText: $0.price.formatted(.currency(code: AppConfigs.defaultCurrency.uppercased()))
        )
    }
}
#endif

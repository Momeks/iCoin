//
//  Date+Extensions.swift
//  iCoin
//
//  Created by Momeks on 26.02.26.
//

import Foundation

extension Date {
    func coinGeckoFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}

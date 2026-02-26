//
//  String+Extensions.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.date(from: self)
    }
}

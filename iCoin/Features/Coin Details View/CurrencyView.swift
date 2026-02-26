//
//  CurrencyView.swift
//  iCoin
//
//  Created by Momeks on 26.02.26.
//


import SwiftUI

struct CurrencyView: View {
    var currency: Currency
    var price: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(currency.flag)
                    .font(.largeTitle)
                
                Text(currency.description)
                    .font(.title3)
                    .fontWeight(.medium)
            }
            
            Text(price)
                .bold()
                .font(.title3)
                .foregroundStyle(.secondary)
        }

    }
}

#Preview {
    CurrencyView(currency: .euro, price: "87932.20")
}

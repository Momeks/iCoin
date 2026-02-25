//
//  ContentView.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                CoinHeaderView(viewModel: CoinViewModel())
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("refresh", systemImage: "arrow.clockwise") {
                        NotificationCenter.default.post(name: .onRefreshData, object: nil)
                    }
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
        }
    }
}

#Preview {
    ContentView()
}

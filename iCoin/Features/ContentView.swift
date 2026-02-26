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
            ScrollView {
                VStack(alignment:.leading, spacing: 10) {
                    CoinHeaderView(viewModel: CoinViewModel())
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Label("Last 14 Days", systemImage: "calendar")
                        .foregroundStyle(.blue)
                        .bold()
                        .padding(.horizontal)
                    
                    MarketChartListView(viewModel: MarketChartViewModel())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("refresh", systemImage: "arrow.clockwise") {
                        RefreshManager.shared.triggerRefresh()
                        NotificationCenter.default.post(name: .onRefreshData, object: nil)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

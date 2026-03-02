//
//  ContentView.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import SwiftUI

struct ContentView: View {
    let dependencies: AppDependencies

    @StateObject private var coinViewModel: CoinViewModel
    @StateObject private var marketChartViewModel: MarketChartViewModel

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        _coinViewModel = StateObject(wrappedValue: dependencies.makeCoinViewModel())
        _marketChartViewModel = StateObject(wrappedValue: dependencies.makeMarketChartViewModel())
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    CoinHeaderView(viewModel: coinViewModel)

                    Divider()
                        .padding(.horizontal)

                    Label("Last 14 Days", systemImage: "calendar")
                        .foregroundStyle(.blue)
                        .bold()
                        .padding(.horizontal)

                    MarketChartListView(
                        viewModel: marketChartViewModel,
                        makeHistoricalDataViewModel: dependencies.makeHistoricalDataViewModel
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("refresh", systemImage: "arrow.clockwise") {
                        dependencies.refreshPublisher.triggerRefresh()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(dependencies: AppDependencies())
}

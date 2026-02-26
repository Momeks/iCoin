//
//  MarketChartListView.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import SwiftUI

struct MarketChartListView<ViewModel: MarketChartProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    var makeHistoricalDataViewModel: (Date) -> HistoricalDataViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                EmptyView()

            case .loading:
                MarketChartLoadingView()

            case .success(let chartDataList):
                ForEach(chartDataList) { data in
                    NavigationLink(destination: CoinDetailView(
                        viewModel: makeHistoricalDataViewModel(data.date))
                    ) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(data.date.formatted(date: .abbreviated, time: .omitted))
                                    .bold()
                                    .foregroundStyle(.secondary)

                                Text(data.priceText)
                                    .bold()

                                Divider()
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                                .imageScale(.small)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            case .failure(let errorMessage):
                ErrorView(errorMessage: errorMessage)
            }
        }
    }
}

#Preview {
    let deps = AppDependencies()
    return ScrollView {
        MarketChartListView(
            viewModel: deps.makeMarketChartViewModel(),
            makeHistoricalDataViewModel: deps.makeHistoricalDataViewModel
        )
    }
}

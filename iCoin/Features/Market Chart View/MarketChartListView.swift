//
//  MarketChartListView.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import SwiftUI

struct MarketChartListView<ViewModel: MarketChartProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                EmptyView()
                
            case .loading:
                MarketChartLoadingView()
                
            case .success(let chartDataList):
                Section {
                    List {
                        ForEach(chartDataList) { data in
                            NavigationLink(destination: EmptyView()) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(data.dateText)
                                        .bold()
                                        .foregroundStyle(.secondary)
                                    Text(data.priceText)
                                        .bold()
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                } header: {
                    Label("Last 14 Days", systemImage: "calendar")
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                
            case .failure(let errorMessage):
                ErrorView(errorMessage: errorMessage)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .onRefreshData)) { _ in
            viewModel.refreshData()
        }
    }
}

#Preview {
    MarketChartListView(viewModel: MarketChartViewModel())
}

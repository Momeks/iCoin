//
//  MarketChartProtocol.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//


import Foundation
import CoinKit
import Combine
import NetworkKit

protocol MarketChartProtocol: ObservableObject {
    var state: MarketChartViewModel.ViewState { get }
    func fetchMarketChartData() async
    func refreshData()
}

class MarketChartViewModel: MarketChartProtocol {
    enum ViewState {
        case idle
        case loading
        case success([MarketChartDTO])
        case failure(String)
    }
    
    @Published private(set) var state: ViewState = .idle
    private let networkService: NetworkService
    private let currency: Currency
    private let endpointProvider: EndpointProvider
    private var currentTask: Task<Void, Never>?
    
    init(networkService: NetworkService = URLSessionNetworkService(),
         endpointProvider: EndpointProvider = CoinGeckoEndpointProvider(),
         currency: Currency = .euro) {
        self.networkService = networkService
        self.endpointProvider = endpointProvider
        self.currency = currency
        
        Task {
            await fetchMarketChartData()
        }
    }
    
    @MainActor
    func fetchMarketChartData() async {
        cancelTask()
        
        state = .loading
        
        let endpoint = endpointProvider.endpoint(for: .marketChart(id: AppConfigs.defaultCoin,
                                                                   currency: AppConfigs.defaultCurrency,
                                                                   days: "14"))
        currentTask = Task {
            do {
                try Task.checkCancellation()
                
                let marketChart: MarketChart = try await networkService.fetch(from: endpoint)
                
                try Task.checkCancellation()
                
                state = .success(mapToViewData(from: marketChart))
                
            } catch is CancellationError {
                return
            } catch let error as NetworkError {
                state = .failure(error.userMessage)
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }
    
    func refreshData() {
        Task {
            await fetchMarketChartData()
        }
    }
    
    private func cancelTask() {
        currentTask?.cancel()
        currentTask = nil
    }
    
    private func mapToViewData(from chart: MarketChart) -> [MarketChartDTO] {
        chart.toHistoricalPrices().map {
            MarketChartDTO(
                date: $0.date,
                priceText: $0.price.formatted(.currency(code: AppConfigs.defaultCurrency))
            )
        }
    }
}

//
//  AppDependencies.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import NetworkKit

final class AppDependencies {

    // MARK: - Networking

    let networkService: NetworkService
    let endpointProvider: EndpointProvider

    // MARK: - Repositories

    let coinRepository: CoinRepositoryProtocol
    let marketChartRepository: MarketChartRepositoryProtocol
    let historicalDataRepository: HistoricalDataRepositoryProtocol

    // MARK: - Shared app services

    let refreshPublisher: RefreshPublisher

    // MARK: - Init

    init(
        networkService: NetworkService = URLSessionNetworkService(),
        endpointProvider: EndpointProvider = CoinGeckoEndpointProvider(),
        refreshPublisher: RefreshPublisher = RefreshManager.shared
    ) {
        self.networkService = networkService
        self.endpointProvider = endpointProvider
        self.refreshPublisher = refreshPublisher

        self.coinRepository = CoinRepository(networkService: networkService, endpointProvider: endpointProvider)
        self.marketChartRepository = MarketChartRepository(networkService: networkService, endpointProvider: endpointProvider)
        self.historicalDataRepository = HistoricalDataRepository(networkService: networkService, endpointProvider: endpointProvider)
    }

    // MARK: - ViewModel factories

    func makeCoinViewModel() -> CoinViewModel {
        CoinViewModel(
            coinRepository: coinRepository,
            refreshPublisher: refreshPublisher
        )
    }

    func makeMarketChartViewModel() -> MarketChartViewModel {
        MarketChartViewModel(marketChartRepository: marketChartRepository, refreshPublisher: refreshPublisher)
    }

    func makeHistoricalDataViewModel(date: Date) -> HistoricalDataViewModel {
        HistoricalDataViewModel(historicalDataRepository: historicalDataRepository, date: date)
    }
}

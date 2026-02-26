//
//  MarketChartRepository.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import CoinKit
import NetworkKit

protocol MarketChartRepositoryProtocol {
    func fetchMarketChart(coinId: String, currency: String, days: String) async throws -> MarketChart
}

final class MarketChartRepository: MarketChartRepositoryProtocol {
    private let networkService: NetworkService
    private let endpointProvider: EndpointProvider

    init(networkService: NetworkService, endpointProvider: EndpointProvider) {
        self.networkService = networkService
        self.endpointProvider = endpointProvider
    }

    func fetchMarketChart(coinId: String, currency: String, days: String) async throws -> MarketChart {
        let endpoint = endpointProvider.endpoint(for: .marketChart(id: coinId, currency: currency, days: days))
        return try await networkService.fetch(from: endpoint)
    }
}

//
//  HistoricalDataRepository.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import CoinKit
import NetworkKit

protocol HistoricalDataRepositoryProtocol {
    func fetchHistoricalData(coinId: String, date: String) async throws -> HistoricalData
}

final class HistoricalDataRepository: HistoricalDataRepositoryProtocol {
    private let networkService: NetworkService
    private let endpointProvider: EndpointProvider

    init(networkService: NetworkService, endpointProvider: EndpointProvider) {
        self.networkService = networkService
        self.endpointProvider = endpointProvider
    }

    func fetchHistoricalData(coinId: String, date: String) async throws -> HistoricalData {
        let endpoint = endpointProvider.endpoint(for: .historicalData(id: coinId, date: date))
        return try await networkService.fetch(from: endpoint)
    }
}

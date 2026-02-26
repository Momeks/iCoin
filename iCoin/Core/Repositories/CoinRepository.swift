//
//  CoinRepository.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import CoinKit
import NetworkKit

protocol CoinRepositoryProtocol {
    func fetchCoin(id: String) async throws -> Coin
}

final class CoinRepository: CoinRepositoryProtocol {
    private let networkService: NetworkService
    private let endpointProvider: EndpointProvider

    init(networkService: NetworkService, endpointProvider: EndpointProvider) {
        self.networkService = networkService
        self.endpointProvider = endpointProvider
    }

    func fetchCoin(id: String) async throws -> Coin {
        let endpoint = endpointProvider.endpoint(for: .coin(id: id))
        return try await networkService.fetch(from: endpoint)
    }
}

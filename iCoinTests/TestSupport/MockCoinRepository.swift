//
//  MockCoinRepository.swift
//  iCoinTests
//

import CoinKit
import NetworkKit

@testable import iCoin

final class MockCoinRepository: CoinRepositoryProtocol {
    private let mockNetworkService: MockNetworkService

    init(networkService: MockNetworkService) {
        self.mockNetworkService = networkService
    }

    func fetchCoin(id: String) async throws -> Coin {
        if mockNetworkService.shouldThrowError {
            throw mockNetworkService.errorToThrow
        }
        guard let coin = mockNetworkService.mockData as? Coin else {
            fatalError("MockNetworkService.mockData must be set to a Coin for success case")
        }
        return coin
    }
}

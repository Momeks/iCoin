//
//  iCoinTests.swift
//  iCoinTests
//
//  Created by Momeks on 26.02.26.
//

import CoinKit
import Combine
import NetworkKit
import XCTest

@testable import iCoin

final class CoinViewModelTests: XCTestCase {
    private var mockService: MockNetworkService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        cancellables = []
    }
    
    /// Verifies that when the repository returns valid coin data,
    /// the view model publishes a `.success` state containing
    /// the expected coin information.
    @MainActor
    func test_FetchCoinData_Success() async throws {
        mockService.mockData = Coin.sample
        let repository = MockCoinRepository(networkService: mockService)
        let viewModel = CoinViewModel(coinRepository: repository,
                                      refreshPublisher: RefreshManager.shared)
        
        let expectation = expectation(description: "Wait for success state")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case let .success(coin) = state {
                    XCTAssertEqual(coin.symbol, "BTC")
                    XCTAssertEqual(coin.name, "Bitcoin")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 3)
    }
    
    /// Verifies that when the repository throws an error,
    /// the view model publishes a `.failure` state containing
    /// a user-friendly error message.
    @MainActor
    func test_FetchCoinData_Failure() async throws {
        mockService.shouldThrowError = true
        mockService.errorToThrow = .invalidResponse
        
        let repository = MockCoinRepository(networkService: mockService)
        let viewModel = CoinViewModel(coinRepository: repository,
                                      refreshPublisher: RefreshManager.shared)
        
        let expectation = expectation(description: "Wait for Failure state")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case let .failure(errorMessage) = state {
                    XCTAssertTrue(errorMessage.contains("Something went wrong. Please try again."))
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 3.0)
    }
    
    override func tearDown() {
        super.tearDown()
        mockService = nil
    }
}

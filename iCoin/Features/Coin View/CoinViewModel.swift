//
//  CoinViewModel.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import CoinKit
import Combine
import NetworkKit
import SwiftUI

protocol CoinViewModelProtocol: ObservableObject {
    var state: CoinViewModel.ViewState { get }
    func fetchCoinData() async
}

class CoinViewModel: CoinViewModelProtocol {
    enum ViewState {
        case idle
        case loading
        case success(CoinDTO)
        case failure(String)
    }
    
    @Published private(set) var state: ViewState = .idle
    private let networkService: NetworkService
    private let endpointProvider: EndpointProvider
    private let refreshPublisher: RefreshPublisher
    
    private var currentTask: Task<Void, Never>?
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkService: NetworkService = URLSessionNetworkService(),
         endpointProvider: EndpointProvider = CoinGeckoEndpointProvider(),
         refreshPublisher: RefreshPublisher = RefreshManager.shared) {
        
        self.networkService = networkService
        self.endpointProvider = endpointProvider
        self.refreshPublisher = refreshPublisher
        
        Task {
            await fetchCoinData()
        }
        
        refreshPublisher.refresh
            .sink { [weak self] in
                Task {
                    await self?.fetchCoinData()
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func fetchCoinData() async {
        cancelTask()
        
        state = .loading
        
        let endpoint = endpointProvider.endpoint(for: .coin(id: AppConfigs.defaultCoin))
        currentTask = Task {
            do {
                try Task.checkCancellation()
                
                let coin: Coin = try await networkService.fetch(from: endpoint)
                
                try Task.checkCancellation()
                
                state = .success(mapToViewData(from: coin))
            } catch is CancellationError {
                return
            } catch let error as NetworkError {
                state = .failure(error.userMessage)
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }
    
    private func cancelTask() {
        currentTask?.cancel()
        currentTask = nil
    }
    
    private func mapToViewData(from coin: Coin) -> CoinDTO {
        return CoinDTO(
            name: coin.name,
            symbol: coin.symbol.uppercased(),
            imageUrl: URL(string: coin.image.large),
            priceText: coin.toCurrencyString(for: AppConfigs.defaultCurrency),
            priceChangeText: String(format: "%+.2f (%.2f%%)", coin.marketData.priceChange24H, coin.marketData.priceChangePercentage24H),
            priceChangeColor: coin.marketData.priceChange24H >= 0 ? .green : .red,
            lastUpdatedText: coin.toDateString()
        )
    }
}

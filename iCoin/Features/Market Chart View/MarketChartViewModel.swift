//
//  MarketChartViewModel.swift
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
}

class MarketChartViewModel: MarketChartProtocol {
    enum ViewState {
        case idle
        case loading
        case success([MarketChartDTO])
        case failure(String)
    }

    @Published private(set) var state: ViewState = .idle
    private let marketChartRepository: MarketChartRepositoryProtocol
    private let refreshPublisher: RefreshPublisher
    private var currentTask: Task<Void, Never>?
    private var cancellables: Set<AnyCancellable> = []

    init(marketChartRepository: MarketChartRepositoryProtocol, refreshPublisher: RefreshPublisher) {
        self.marketChartRepository = marketChartRepository
        self.refreshPublisher = refreshPublisher

        Task {
            await fetchMarketChartData()
        }

        refreshPublisher.refresh
            .sink { [weak self] in
                Task {
                    await self?.fetchMarketChartData()
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    func fetchMarketChartData() async {
        cancelTask()

        state = .loading

        currentTask = Task {
            do {
                try Task.checkCancellation()

                let marketChart = try await marketChartRepository.fetchMarketChart(
                    coinId: AppConfigs.defaultCoin,
                    currency: AppConfigs.defaultCurrency,
                    days: "14"
                )

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

//
//  HistoricalDataViewModel.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import CoinKit
import Combine
import NetworkKit

protocol HistoricalDataProtocol: ObservableObject {
    var state: HistoricalDataViewModel.ViewState { get }
    var availableCurrencies: [Currency] { get }
    var navigationTitle: String { get }
    func fetchHistoricalData() async
}

class HistoricalDataViewModel: HistoricalDataProtocol {
    var date: Date
    var availableCurrencies: [Currency] { [.euro, .usd, .pound] }
    var navigationTitle: String { date.formatted(date: .abbreviated, time: .omitted) }

    enum ViewState {
        case idle
        case loading
        case success(HistoricalDTO)
        case failure(String)
    }

    @Published private(set) var state: ViewState = .idle
    private let historicalDataRepository: HistoricalDataRepositoryProtocol
    private var currentTask: Task<Void, Never>?

    init(historicalDataRepository: HistoricalDataRepositoryProtocol, date: Date) {
        self.historicalDataRepository = historicalDataRepository
        self.date = date

        Task {
            await fetchHistoricalData()
        }
    }

    @MainActor
    func fetchHistoricalData() async {
        cancelTask()

        state = .loading

        currentTask = Task {
            do {
                try Task.checkCancellation()

                let historicalData = try await historicalDataRepository.fetchHistoricalData(
                    coinId: AppConfigs.defaultCoin,
                    date: date.coinGeckoFormattedDate()
                )

                try Task.checkCancellation()

                state = .success(mapToViewData(from: historicalData))
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

    private func mapToViewData(from data: HistoricalData) -> HistoricalDTO {
        let rawPrices = data.marketData?.currentPrice ?? [:]

        let formattedPrices = rawPrices.reduce(into: [Currency: String]()) { dict, pair in
            if let currency = Currency(rawValue: pair.key.lowercased()) {
                let formatted = pair.value.formatted(.currency(code: currency.id.uppercased()))
                dict[currency] = formatted
            }
        }

        return HistoricalDTO(
            name: data.name,
            symbol: data.symbol.uppercased(),
            pricesByCurrency: formattedPrices
        )
    }
}

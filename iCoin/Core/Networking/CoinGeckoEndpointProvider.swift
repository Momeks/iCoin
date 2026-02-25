//
//  CoinGeckoEndpointProvider.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Foundation
import NetworkKit

protocol EndpointProvider {
    func endpoint(for path: CoinGeckoPath) -> Endpoint
}

class CoinGeckoEndpointProvider: EndpointProvider {
    private let apiKey: String

    init(apiKey: String = AppConfigs.coinGeckoAPIKey) {
        self.apiKey = apiKey
    }

    func endpoint(for path: CoinGeckoPath) -> Endpoint {
        return CoinGeckoEndpoint(pathType: path, apiKey: apiKey)
    }
}

//
//  RefreshManager.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import Combine
import Foundation
import UIKit

protocol RefreshPublisher {
    var refresh: AnyPublisher<Void, Never> { get }
    func triggerRefresh()
}

final class RefreshManager: RefreshPublisher {
    static let shared = RefreshManager()

    private var timerSubscription: AnyCancellable?
    private let refreshSubject = PassthroughSubject<Void, Never>()

    var refresh: AnyPublisher<Void, Never> {
        refreshSubject.eraseToAnyPublisher()
    }

    func triggerRefresh() {
        refreshSubject.send(())
    }

    private init() {
        setupLifecycleObservers()
        startTimer()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func startTimer() {
        stopTimer()
        timerSubscription = Timer
            .publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.refreshSubject.send(())
            }
    }

    private func stopTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }

    private func setupLifecycleObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    @objc private func appDidEnterBackground() { stopTimer() }
    @objc private func appWillEnterForeground() { startTimer() }
}

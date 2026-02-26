//
//  iCoinApp.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import SwiftUI

@main
struct iCoinApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(dependencies: AppDependencies())
        }
    }
}

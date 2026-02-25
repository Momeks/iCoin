//
//  ErrorView.swift
//  iCoin
//
//  Created by Momeks on 25.02.26.
//

import SwiftUI

struct ErrorView: View {
    var errorMessage: String
    
    var body: some View {
        ContentUnavailableView("Error",
                               systemImage: "exclamationmark.triangle",
                               description: Text(errorMessage).foregroundStyle(.secondary)
        )
    }
}

#Preview {
    ErrorView(errorMessage: "Something Wrong")
}

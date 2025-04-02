//
//  CardModel.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 29.03.2025.
//

import Foundation

struct CardModel: Identifiable {
    let id: UUID
    let symbol: String
    var isMatched: Bool
    var isFlipped: Bool

    init(symbol: String, isMatched: Bool = false, isFlipped: Bool = false) {
        self.id = UUID()
        self.symbol = symbol
        self.isMatched = isMatched
        self.isFlipped = isFlipped
    }
}

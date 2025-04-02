//
//  CardView.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 29.03.2025.
//

import SwiftUI
import CardUIComponents

struct CardView: View {
    let card: CardModel
    let theme: ThemeModel

    var body: some View {
        ZStack {
            if card.isFlipped {
                CardViewComponent(
                    backgroundColor: .white,
                    symbol: card.symbol
                )
            } else {
                CardViewComponent(
                    backgroundColor: theme.cardColor,
                    symbol: theme.cardSymbol
                )
            }
        }
        .modifier(FlipAnimation(isFlipped: card.isFlipped))
    }
}

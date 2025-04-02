//
//  FlipAnimation.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 29.03.2025.
//


import SwiftUI

struct FlipAnimation: ViewModifier {
    let isFlipped: Bool

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                Angle(degrees: isFlipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .animation(.easeInOut(duration: 0.5), value: isFlipped)
    }
}

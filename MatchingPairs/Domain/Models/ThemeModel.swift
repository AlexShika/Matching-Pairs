//
//  ThemeModel.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 01.04.2025.
//


import Foundation
import SwiftUI

struct ThemeModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let symbols: [String]
    let cardSymbol: String
    let cardColor: Color
}

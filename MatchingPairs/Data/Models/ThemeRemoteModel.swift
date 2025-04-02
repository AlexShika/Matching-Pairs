//
//  ThemeRemoteModel.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 01.04.2025.
//

import Foundation

struct ThemeRemoteModel: Decodable {
    let title: String
    let symbols: [String]
    let cardSymbol: String
    let cardColor: ColorRemoteModel

    enum CodingKeys: String, CodingKey {
        case title
        case symbols
        case cardSymbol = "card_symbol"
        case cardColor = "card_color"
    }
}

struct ColorRemoteModel: Decodable {
    let red: Double
    let green: Double
    let blue: Double
}

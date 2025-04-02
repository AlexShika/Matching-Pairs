//
//  ThemeRepositoryImplementation.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 01.04.2025.
//


import Foundation
import SwiftUI

class ThemeRepositoryImplementation: ThemeRepository {
    private let themeService = ThemeService()

    func fetchThemes(completion: @escaping ([ThemeModel]) -> Void) {
        themeService.fetchThemes { themesRemote in
            let themes = themesRemote.map { theme in
                ThemeModel(
                    title: theme.title,
                    symbols: theme.symbols,
                    cardSymbol: theme.cardSymbol,
                    cardColor: Color(.sRGB, red: theme.cardColor.red, green: theme.cardColor.green, blue: theme.cardColor.blue, opacity: 1.0)
                )
            }
            completion(themes)
        }
    }
}

//
//  MatchingPairsApp.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 29.03.2025.
//

import SwiftUI

@main
struct MatchingPairsApp: App {
    @StateObject private var rootViewModel = RootViewModel(
        fetchThemesUseCase: FetchThemesUseCase(repository: ThemeRepositoryImplementation())
    )
    @AppStorage("appearanceSelection") private var appearanceSelection: Int = 0
    
    var appearanceSwitch: ColorScheme? {
        switch appearanceSelection {
        case 1:
            return .light
        case 2:
            return .dark
        default:
            return .none
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(rootViewModel)
                .preferredColorScheme(appearanceSwitch)
        }
    }
}

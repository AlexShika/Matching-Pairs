//
//  DifficultyLevel.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 02.04.2025.
//

import Foundation

enum DifficultyLevel: Int, CaseIterable, Identifiable {
    case easy = 60
    case medium = 30
    case hard = 10

    var id: Int { rawValue }

    var displayName: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
}

//
//  ThemeRepository.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 01.04.2025.
//


protocol ThemeRepository {
    func fetchThemes(completion: @escaping ([ThemeModel]) -> Void)
}

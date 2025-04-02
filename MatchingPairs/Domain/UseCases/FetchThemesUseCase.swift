//
//  FetchThemesUseCase.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 01.04.2025.
//


class FetchThemesUseCase {
    private let repository: ThemeRepository

    init(repository: ThemeRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping ([ThemeModel]) -> Void) {
        repository.fetchThemes(completion: completion)
    }
}

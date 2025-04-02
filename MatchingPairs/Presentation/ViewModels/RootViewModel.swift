import SwiftUI

class RootViewModel: ObservableObject {
    @Published var availableThemes: [ThemeModel] = []
    @Published var selectedTheme: ThemeModel?
    @Published var isLoading: Bool = false
    @Published var navDestination: NavigationDestination? = nil
    @Published var difficultyLevel: DifficultyLevel = .easy
    @Published var nickname: String = "The Gamer"

    @AppStorage("appearanceSelection") var appearanceSelection: Int = 0

    private let fetchThemesUseCase: FetchThemesUseCase

    init(fetchThemesUseCase: FetchThemesUseCase) {
        self.fetchThemesUseCase = fetchThemesUseCase
        fetchThemes()
    }

    func fetchThemes() {
        isLoading = true
        fetchThemesUseCase.execute { [weak self] themes in
            DispatchQueue.main.async {
                self?.availableThemes = themes
                self?.selectedTheme = themes.first
                self?.isLoading = false
            }
        }
    }

    func onTapStartGame() {
        guard let theme = selectedTheme, !nickname.isEmpty else { return }
        let gameDuration = difficultyLevel.rawValue
        navDestination = .game(vm: GameViewModel(theme: theme, gameDuration: gameDuration, nickname: nickname))
    }

    func onTapShowHighScores() {
        navDestination = .highScores
    }
}

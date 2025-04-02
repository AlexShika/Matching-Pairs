import SwiftUI

class HighScoresViewModel: ObservableObject {
    @AppStorage("highScores") private var highScoresData: String = "[]"
    @Published var highScores: [HighScore] = []

    init() {
        loadHighScores()
    }

    func loadHighScores() {
        guard let data = highScoresData.data(using: .utf8),
              let decodedHighScores = try? JSONDecoder().decode([HighScore].self, from: data) else {
            highScores = []
            return
        }
        highScores = decodedHighScores.sorted(by: {$0.score > $1.score})
    }
}

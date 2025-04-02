import SwiftUI

struct HighScoresView: View {
    @StateObject private var viewModel = HighScoresViewModel()

    var body: some View {
        VStack {
            Text("High Scores")
                .font(.largeTitle)
                .padding()

            List($viewModel.highScores) { score in
                HStack {
                    Text(score.nickname.wrappedValue)
                        .font(.headline)
                    Spacer()
                    Text("\(score.score.wrappedValue) points")
                        .font(.subheadline)
                    Text("(\(DifficultyLevel.init(rawValue: score.difficulty.wrappedValue)?.displayName ?? DifficultyLevel.easy.displayName))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }.listStyle(.plain)
            Spacer()
        }
        .padding()
    }
}

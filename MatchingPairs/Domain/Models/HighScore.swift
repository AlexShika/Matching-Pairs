import Foundation

struct HighScore: Codable, Identifiable {
    let id: UUID
    var nickname: String
    var score: Int
    var difficulty: DifficultyLevel.RawValue
    let timestamp: Date

    init(nickname: String, score: Int, difficulty: DifficultyLevel.RawValue, timestamp: Date = Date()) {
        self.id = UUID()
        self.nickname = nickname
        self.score = score
        self.difficulty = difficulty
        self.timestamp = timestamp
    }
}

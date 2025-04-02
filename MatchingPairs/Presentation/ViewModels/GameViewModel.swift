//
//  GameViewModel.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 29.03.2025.
//

import SwiftUI
import SwiftData

class GameViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var score: Int
    @Published var timeRemaining: Int
    @Published var currentTheme: ThemeModel
    @Published var gameButtonState: GameButtonState
    
    @AppStorage("highScores") private var highScoresData: String = "[]"
    
    private var flippedCards: [CardModel] = []
    private var timer: Timer?
    private var numberOfMoves: Int
    private var gameDuration: Int
    private var nickname: String
    
    struct Constants {
        static let movePenalty = 1
        static let scoreIncrement = 10
        static let scorePernalty = 2
        static let maxCardTypeCount = 4
        static let matchedCardDelay = 0.5
        static let resetFlippedCardsDelayDuration = 0.5
        static let cardGridColumnCount = 4
    }
    
    enum GameButtonState {
        case start
        case reset
        case end
    }
    
    init(theme: ThemeModel, gameDuration: Int, nickname: String) {
        self.currentTheme = theme
        self.score = 0
        self.numberOfMoves = 0
        self.timeRemaining = gameDuration
        self.gameDuration = gameDuration
        self.nickname = nickname
        self.gameButtonState = .start

        initiateGameCards()
    }
    
    func startGame() {
        hideAllCards()
        startTimer()
        self.gameButtonState = .reset
    }
    
    func resetGame() {
        initiateGameCards()
        timer?.invalidate()
        score = 0
        timeRemaining = gameDuration
        self.gameButtonState = .start
    }
    
    func endGame() {
        score = calculateFinalScore()
        saveHighScore(HighScore(nickname: nickname, score: score, difficulty: gameDuration))
        self.gameButtonState = .end
    }
    
    func selectCard(_ card: CardModel) {
        guard !card.isMatched,
                flippedCards.count < 2,
                !flippedCards.contains(where: { $0.id == card.id }) else { return }

        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isFlipped = true
            flippedCards.append(cards[index])

            if flippedCards.count == 2 {
                numberOfMoves += 1
                checkForMatch()
            }
        }
    }
}

private extension GameViewModel {
    func initiateGameCards() {
        let selectedSymbols = currentTheme.symbols.shuffled().prefix(Constants.maxCardTypeCount)

        cards = selectedSymbols.flatMap { symbol in
            [CardModel(symbol: symbol, isFlipped: true), CardModel(symbol: symbol, isFlipped: true)]
        }.shuffled()
    }
    
    func hideAllCards() {
        cards.enumerated().forEach { cards[$0.offset].isFlipped = false }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            if self.cards.allSatisfy({ $0.isMatched }) || self.timeRemaining == 0 {
                self.timer?.invalidate()
                return
            }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
            }
        }
    }
    
    func checkForMatch() {
        guard flippedCards.count == 2 else { return }

        let firstCard = flippedCards[0]
        let secondCard = flippedCards[1]

        if firstCard.symbol == secondCard.symbol {
            markCardsAsMatched(firstCard, secondCard)
            score += Constants.scoreIncrement
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.resetFlippedCardsDelayDuration) {
                self.resetFlippedCards()
            }
        }
    }
    
    func markCardsAsMatched(_ firstCard: CardModel, _ secondCard: CardModel) {
        if let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }),
           let secondIndex = cards.firstIndex(where: { $0.id == secondCard.id }) {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.matchedCardDelay) {
                self.cards[firstIndex].isMatched = true
                self.cards[secondIndex].isMatched = true
            }
        }
        
        self.flippedCards.removeAll()
    }
    
    func resetFlippedCards() {
        for flippedCard in flippedCards {
            if let index = cards.firstIndex(where: { $0.id == flippedCard.id }) {
                cards[index].isFlipped = false
            }
        }
        flippedCards.removeAll()
    }
    
    func calculateFinalScore() -> Int {
        
        let difficultyMultiplier: Double
        switch gameDuration {
        case DifficultyLevel.easy.rawValue:
            difficultyMultiplier = 1.0
        case DifficultyLevel.medium.rawValue:
            difficultyMultiplier = 1.5
        case DifficultyLevel.hard.rawValue:
            difficultyMultiplier = 2.0
        default:
            difficultyMultiplier = 1.0
        }
        
        let penalty = abs(numberOfMoves - Constants.maxCardTypeCount) * Constants.movePenalty
        
        let finalScore = Int((Double(score) * difficultyMultiplier) - Double(penalty))
        return max(finalScore, 0)
    }
    
    func saveHighScore(_ highScore: HighScore) {
        var highScores = loadHighScores()
        highScores.append(highScore)
        if highScores.count > 10 {
            highScores = highScores.suffix(10)
        }
        if let encoded = try? JSONEncoder().encode(highScores) {
            highScoresData = String(data: encoded, encoding: .utf8) ?? "[]"
        }
    }

    func loadHighScores() -> [HighScore] {
        guard let data = highScoresData.data(using: .utf8),
              let highScores = try? JSONDecoder().decode([HighScore].self, from: data) else {
            return []
        }
        return highScores
    }
}

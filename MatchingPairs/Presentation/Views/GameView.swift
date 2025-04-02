//
//  GameView.swift
//  MatchingPairs
//
//  Created by Alexandru Dinu on 29.03.2025.
//

import SwiftUI
import CardUIComponents

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        GeometryReader { geometry in
            contentView(for: geometry.size)
                .onChange(of: viewModel.timeRemaining) { newValue in
                    if newValue == 0 {
                        viewModel.endGame()
                    }
                }
                .onChange(of: viewModel.cards.allSatisfy({ $0.isMatched })) { newValue in
                    if newValue {
                        viewModel.endGame()
                    }
                }
        }
    }
}

extension GameView {
    func contentView(for size: CGSize) -> some View {
        VStack(alignment: .center) {
            Text("Score: \(viewModel.score)")
                .font(size.width > size.height ? .title : .largeTitle)
                .foregroundColor(.blue)
            if size.width <= size.height {
                Spacer()
            }
            if viewModel.cards.allSatisfy({ $0.isMatched }) {
                Text("You won!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding()
            } else if viewModel.timeRemaining == 0 {
                Text("Time's up! Try again!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding()
            } else {
                gridView(for: size)
                    .frame(maxWidth: 400)
            }

            Spacer()

            buttonView

            Text("Time left: \(viewModel.timeRemaining) seconds")
                .font(.headline)
                .padding()
                .foregroundColor(viewModel.timeRemaining > 10 ? Color(.label) : .red)
        }
        .frame(maxWidth: .infinity)
    }

    func gridView(for size: CGSize) -> some View {
        let changeLayout = (size.width > size.height &&
                            UIDevice.current.userInterfaceIdiom != .pad)
        let columns = changeLayout ? 5 : 3
        let frameSize: CGSize =  changeLayout ? CGSize(width: 50, height: 80) : CGSize(width: 100, height: 150)
        let font: Font = changeLayout ? .title : .largeTitle
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: columns),
                         alignment: .center,
                         spacing: 10) {
            ForEach(viewModel.cards) { card in
                if card.isMatched {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: frameSize.width, height: frameSize.height)
                } else {
                    cardView(for: card, size: frameSize, font: font)
                        .onTapGesture {
                            viewModel.selectCard(card)
                        }
                }
            }
        }
    }
    
    func cardView(for card: CardModel, size: CGSize, font: Font) -> some View {
        ZStack {
            if card.isFlipped {
                CardViewComponent(
                    backgroundColor: .white,
                    symbol: card.symbol,
                    fontSize: font,
                    frameSize: size
                )
            } else {
                CardViewComponent(
                    backgroundColor: viewModel.currentTheme.cardColor,
                    symbol: viewModel.currentTheme.cardSymbol,
                    fontSize: font,
                    frameSize: size
                )
            }
        }
        .modifier(FlipAnimation(isFlipped: card.isFlipped))
    }

    var buttonView: some View {
        Button {
            switch viewModel.gameButtonState {
            case .start:
                viewModel.startGame()
            case .reset, .end:
                viewModel.resetGame()
            }
        } label: {
            switch viewModel.gameButtonState {
            case .start:
                Text("Start")
            case .reset:
                Text("Reset")
            case .end:
                Text("Restart")
            }
        }
        .font(.title2)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

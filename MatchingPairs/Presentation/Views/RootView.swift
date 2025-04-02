import SwiftUI
import CardUIComponents

struct RootView: View {
    @EnvironmentObject var viewModel: RootViewModel
    @State private var navDestination: NavigationDestination = .none

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                contentView(for: geometry.size)
                    .navigationTitle("Matching Pairs")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension RootView {
    func contentView(for size: CGSize) -> some View {
        VStack(spacing: 20) {
            if size.width > size.height {
                HStack {
                    VStack(spacing: 20) {
                        appearancePickerView
                        difficultyPickerView
                        nicknameInputView
                    }
                    Spacer()
                    themeView
                }
                Spacer()
                HStack {
                    startGameButton
                    highScoresButton
                }
            } else {
                appearancePickerView
                difficultyPickerView
                nicknameInputView
                themeView
                Spacer()
                startGameButton
                highScoresButton
            }

            NavigationLink(
                destination: buildNextView(),
                tag: navDestination,
                selection: $viewModel.navDestination,
                label: { EmptyView() }
            )
        }
        .onChange(of: viewModel.navDestination) { newValue in
            guard let newNavDestination = newValue else {
                navDestination = .none
                return
            }
            navDestination = newNavDestination
        }
        .padding()
    }

    var appearancePickerView: some View {
        HStack {
            Text("Select Appearance")
            Spacer()
            Picker("", selection: $viewModel.appearanceSelection) {
                Text("System")
                    .tag(0)
                Text("Light")
                    .tag(1)
                Text("Dark")
                    .tag(2)
            }
        }
    }

    var difficultyPickerView: some View {
        HStack {
            Text("Select Difficulty")
            Spacer()
            Picker("", selection: $viewModel.difficultyLevel) {
                ForEach(DifficultyLevel.allCases) { level in
                    Text(level.displayName).tag(level)
                }
            }
        }
    }

    var nicknameInputView: some View {
        HStack {
            Text("Enter Nickname")
            Spacer()
            TextField("Nickname", text: $viewModel.nickname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200)
        }
    }

    var themeView: some View {
        VStack {
            HStack {
                Text("Select Theme")
                Spacer()
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Picker("Select Theme", selection: $viewModel.selectedTheme) {
                        ForEach(viewModel.availableThemes) { theme in
                            Text(theme.title).tag(theme as ThemeModel?)
                        }
                    }
                }
            }

            if !viewModel.isLoading,
               let theme = viewModel.selectedTheme {
                HStack {
                    CardViewComponent(
                        backgroundColor: theme.cardColor,
                        symbol: theme.cardSymbol
                    )
                    CardViewComponent(
                        backgroundColor: .white,
                        symbol: theme.symbols.first ?? ""
                    )
                }
            }
        }
    }

    var startGameButton: some View {
        Button(action: {
            viewModel.onTapStartGame()
        }) {
            Text("Start Game")
                .font(.title2)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }

    var highScoresButton: some View {
        Button(action: {
            viewModel.onTapShowHighScores()
        }) {
            Text("View High Scores")
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }

    @ViewBuilder
    private func buildNextView() -> some View {
        switch navDestination {
        case .game(let vm):
            GameView(viewModel: vm)
        case .highScores:
            HighScoresView()
        case .none:
            EmptyView()
        }
    }
}

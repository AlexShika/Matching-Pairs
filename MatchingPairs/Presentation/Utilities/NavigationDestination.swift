enum NavigationDestination: Hashable {
    case game(vm: GameViewModel)
    case highScores
    case none

    func hash(into hasher: inout Hasher) {
        var index = 0
        switch self {
        case .game:
            index = 1
        case .highScores:
            index = 2
        case .none:
            index = 0
        }
        hasher.combine(index)
    }

    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

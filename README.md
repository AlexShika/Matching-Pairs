# MatchingPairs

**MatchingPairs** is a card-matching game built with SwiftUI. The game challenges players to match pairs of cards within a time limit, with difficulty levels and customizable themes. It also includes a high scores feature to track the top 10 scores.

---

## Features

- **Card Matching Gameplay**: Flip cards to find matching pairs.
- **Difficulty Levels**: Choose between Easy, Medium, and Hard modes, which adjust the time limit.
- **Customizable Themes**: Select from various themes with unique card designs.
- **High Scores**: Tracks the top 10 scores, including player nickname, score, and difficulty level.
- **Dynamic Layout**: Supports both portrait and landscape orientations.
- **Light/Dark Mode**: Toggle between light and dark modes for the app.

---

## Requirements

- **iOS**: 15.0+
- **Xcode**: 13.0+
- **Swift**: 5.5+

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/AlexShika/MatchingPairs.git
   ```
2. Open the project in Xcode.
3. Build and run the app on a simulator or device.

---

## Usage

### **Gameplay**

1. Launch the app.
2. Enter your nickname in the **Nickname** field.
3. Select a difficulty level (Easy, Medium, Hard).
4. Choose a theme for the cards.
5. Tap **Start Game** to begin.
6. Flip cards to find matching pairs before the timer runs out.

### **High Scores**

- Tap **View High Scores** on the main screen to see the top 10 scores.
- High scores include:
  - Player nickname
  - Score
  - Difficulty level

---

## Project Structure

The project follows the **Clean Architecture** pattern, with three main layers: **Data**, **Domain**, and **Presentation**.

### **1. Data Layer**
Handles data fetching and mapping from remote sources.

- **Models**: Defines data models for remote APIs.
  - `ThemeRemoteModel.swift`
- **Repositories**: Implements data access logic.
  - `ThemeRepositoryImpl.swift`
- **Services**: Handles API calls.
  - `ThemeService.swift`

### **2. Domain Layer**
Contains business logic and core models.

- **Models**: Defines core app models.
  - `ThemeModel.swift`
  - `CardModel.swift`
  - `HighScore.swift`
- **Repositories**: Protocols for data access.
  - `ThemeRepository.swift`
- **Use Cases**: Encapsulates business logic.
  - `FetchThemesUseCase.swift`

### **3. Presentation Layer**
Handles UI and user interaction.

- **Views**: SwiftUI views for the app.
  - `RootView.swift`
  - `GameView.swift`
  - `HighScoresView.swift`
  - `CardView.swift`
- **ViewModels**: Manages state and logic for views.
  - `RootViewModel.swift`
  - `GameViewModel.swift`
  - `HighScoresViewModel.swift`
- **Utilities**: Shared utilities and helpers.
  - `DifficultyLevel.swift`
  - `FlipAnimation.swift`
  - `NavigationDestination.swift`

---

## Key Components

### **1. Themes**
Themes define the appearance of cards, including symbols and colors.

- **Theme Selection**: Choose a theme from the main screen.
- **Customization**: Themes are fetched from a remote API.

### **2. Difficulty Levels**
Adjust the game's time limit based on the selected difficulty:
- **Easy**: 60 seconds
- **Medium**: 30 seconds
- **Hard**: 10 seconds

### **3. High Scores**
Tracks the top 10 scores using `@AppStorage` for persistence.

---

## Dynamic Layout

The app supports both portrait and landscape orientations:
- **Portrait**: Vertical layout with stacked elements.
- **Landscape**: Horizontal layout with side-by-side elements.

---

## Dependencies

The project uses the following dependency:

- **[CardUIComponents](https://github.com/AlexShika/CardUIComponents)**: A Swift Package for reusable card UI components.

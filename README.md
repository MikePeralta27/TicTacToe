# TicTacToe — iOS

A classic 3×3 Tic-Tac-Toe game for iOS, built with **Swift** and **UIKit** using a clear **MVC** architecture. This project is intended as a portfolio piece demonstrating separation of concerns, testable model design, and structured iOS app layout.

---

## Game overview

Two players take turns placing **X (Crosses)** and **O (Noughts)** on a 3×3 grid. The first to get three in a row — horizontally, vertically, or diagonally — wins. If all nine cells are filled with no winner, the game is a draw.

**Features:**

- Turn indicator showing who plays next (Crosses or Noughts)
- Score tracking for Noughts vs Crosses across multiple rounds
- Win and draw detection with an alert and optional reset
- Board disabled after game over; reset clears the grid and alternates who starts first

---

## Technical stack

| Category      | Choice        |
|---------------|----------------|
| Language      | Swift 5        |
| UI            | UIKit, Storyboards |
| Architecture  | MVC (Model–View–Controller) |
| Min. iOS      | Set in Xcode project (see **Getting started**) |
| IDE           | Xcode          |

---

## Architecture (MVC)

### Model (`GameModel.swift`)

- **Responsibility:** All game state and rules; no UI.
- **State:** Board as `[String?]` (9 cells), current turn, first turn, Noughts/Crosses scores.
- **API:** `play(at:)`, `resetForNewGame()`, `checkForVictory(for:)`, `isBoardFull`, `symbol(for:)`.
- **Dependencies:** `Foundation` only (no `UIKit`), so the model is testable and reusable.

### View

- **Storyboard:** 3×3 grid of buttons, turn label, layout and constraints.
- **Assets:** App icon, accent color, launch screen. No game logic.

### Controller (`ViewController.swift`)

- **Responsibility:** React to taps, call the model, update the UI from the model.
- **Flow:** Tap → `play(at:)` → update button title and turn label; after each move, check win/draw and show alert if needed; on reset, call model reset then clear titles and re-enable buttons.

Single source of truth is the model; the controller only reflects its state.

---

## Design decisions

- **Win detection:** Eight winning lines (3 rows, 3 columns, 2 diagonals) are defined as index triplets in one array; one loop over the model’s board checks for a win. No duplicated conditionals and no dependency on UI.
- **Reset:** Model clears board and alternates first turn; controller clears button titles and re-enables the board, then sets the turn label from the model.
- **Game-over UX:** Board is disabled when the win/draw alert is shown; re-enabled only after the user taps Reset.
- **Symbols and constants:** Stored in the model (`GameModel.crossSymbol`, `GameModel.noughtSymbol`); the controller uses these instead of defining its own.

---

## Project structure

```
TicTacToe/
├── TicTacToe.xcodeproj
├── TicTacToe/
│   ├── Controller/
│   │   └── ViewController.swift    # Tap handling, UI updates, alerts
│   ├── Model/
│   │   └── GameModel.swift        # Board, turns, scores, win/draw logic
│   ├── View/
│   │   └── Base.lproj/
│   │       └── Main.storyboard    # Grid and turn label
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── Info.plist
│   ├── Base.lproj/
│   │   └── LaunchScreen.storyboard
│   ├── Assets.xcassets/
│   └── TicTacToe.xcdatamodeld/    # Core Data (template; optional)
├── .gitignore
└── README.md
```

---

## Getting started

### Requirements

- **Xcode** (latest stable recommended)
- **macOS** (for running Xcode and iOS Simulator)
- **iOS** deployment target as set in the project (open the project in Xcode to check)

### Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/TicTacToe.git
   cd TicTacToe
   ```

2. **Open in Xcode**
   - Open `TicTacToe.xcodeproj` (double-click or `open TicTacToe.xcodeproj`).

3. **Select a run destination**
   - Choose an **iPhone Simulator** (or a connected device) from the scheme toolbar.

4. **Build and run**
   - Press **⌘R** or use **Product → Run**.
   - Tap cells to play; use **Reset** in the alert after a win or draw to start a new round.

No external dependencies or package managers; the project uses only the iOS SDK.

---

## Author

**Michael Peralta**  
Part of my iOS portfolio. If you’re reviewing this as an employer or collaborator, I’m happy to walk through the architecture and design choices in more detail.

---

## License

This project is for portfolio and educational use. See repository or contact author for reuse terms.

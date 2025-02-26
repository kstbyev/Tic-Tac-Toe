# Tic Tac Toe Game

## Description
Tic Tac Toe is a classic two-player game where players take turns marking a space in a 3x3 grid with their respective symbols (X or O). This implementation allows players to play against each other or against an AI bot with adjustable difficulty levels. The bot uses strategic algorithms to provide a challenging experience.

## 📸 Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/204d4be9-5032-48ec-95d8-c50d4afa44fa" width="200" alt="Home Screen">
</p>

## 🎥 Demo

<p align="center">
  <img src="https://github.com/user-attachments/assets/5eed92a6-72a1-402a-bbb0-eb8f9e62a128" width="250" alt="App Demo">
  <img src="https://github.com/user-attachments/assets/63947454-1764-4b61-9a74-b9d43ebcefa6" width="250" alt="App Demo2">
</p>


### Library Structure
The project is organized into the following key components:

- **GameLogic.swift**: Contains the core game logic, including the rules of Tic Tac Toe, AI decision-making, and game state management. This file handles player moves, checks for winners, and implements the AI's behavior based on the selected difficulty level.

- **ContentView.swift**: The main user interface of the application, built using SwiftUI. This file defines the layout of the game board, handles user interactions, and displays the current game state, including scores and messages.

- **Persistence.swift**: Manages data persistence using Core Data, allowing for future enhancements such as saving game history or player statistics.

- **Assets.xcassets**: Contains image assets and color sets used in the application, ensuring a visually appealing design.

- **Supporting Files**: Includes project configuration files, such as the Info.plist and project settings, which are necessary for the app's functionality.

## Tech Stack
This project is built using the following technologies:

- **Swift**: The primary programming language used for developing the application, providing a modern and safe coding experience.

- **SwiftUI**: A user interface toolkit that allows for declarative UI design, making it easy to create responsive and dynamic interfaces.

- **Core Data**: A framework used for data management and persistence, allowing for the storage of game data and player statistics.

- **Xcode**: The integrated development environment (IDE) used for building and testing the application, providing tools for debugging and performance analysis.

## Features
- **Two Game Modes**: Play against a friend or an AI bot.
- **Adjustable AI Difficulty**: Choose between Easy, Medium, and Hard difficulty levels for the AI.
- **Smart AI**: The AI prioritizes taking the center, blocking winning moves, and taking corners.
- **Score Tracking**: Keep track of scores for both players.
- **Responsive Design**: The game is designed to be user-friendly and visually appealing.

## Installation
To run the Tic Tac Toe game locally, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/kstbyev/tic-tac-toe.git
   ```

2. **Open the Project**:
   Open the project in Xcode.

3. **Run the App**:
   Select a simulator or a connected device and click the "Run" button in Xcode.

## Usage
- Start the app, and you will see the Tic Tac Toe grid.
- Choose whether to play against a friend or the AI by toggling the option.
- If playing against the AI, select the desired difficulty level.
- Take turns placing your symbols in the grid.
- The game will announce the winner or declare a draw when applicable.
- You can reset the game at any time using the "Reset Game" button.

## Contributing
Contributions are welcome! If you would like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and commit them.
4. Push your changes to your forked repository.
5. Create a pull request describing your changes.

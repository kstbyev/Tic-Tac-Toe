//
//  GameLogic.swift
//  Tic Tac Toe
//
//  Created by Madi Sharipov on 26.02.2025.
//

import Foundation

enum BotLevel: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

class GameLogic: ObservableObject {
    @Published var board: [[String]] = [["", "", ""], ["", "", ""], ["", "", ""]]
    @Published var currentPlayer: String = "X"
    @Published var winner: String? = nil
    @Published var xScore: Int = 0
    @Published var oScore: Int = 0
    @Published var isTwoPlayerMode: Bool = true // Track game mode
    @Published var botLevel: BotLevel = .easy // Track bot difficulty level

    func makeMove(row: Int, col: Int) {
        guard board[row][col] == "" else { return }
        board[row][col] = currentPlayer
        if checkForWinner() {
            winner = currentPlayer
            updateScore()
        } else {
            currentPlayer = currentPlayer == "X" ? "O" : "X"
            if !isTwoPlayerMode && currentPlayer == "O" {
                aiMove()
            }
        }
    }

    private func aiMove() {
        switch botLevel {
        case .easy:
            makeRandomMove()
        case .medium:
            if !blockWinningMove() {
                makeRandomMove()
            }
        case .hard:
            if !takeCenterIfAvailable() {
                if !blockWinningMove() {
                    if !takeCornerIfAvailable() {
                        makeOptimalMove()
                    }
                }
            }
        }
    }

    private func takeCenterIfAvailable() -> Bool {
        if board[1][1] == "" {
            board[1][1] = currentPlayer
            if checkForWinner() {
                winner = currentPlayer
                updateScore()
            } else {
                currentPlayer = "X"
            }
            return true
        }
        return false
    }

    private func takeCornerIfAvailable() -> Bool {
        let corners = [(0, 0), (0, 2), (2, 0), (2, 2)]
        for corner in corners {
            if board[corner.0][corner.1] == "" {
                board[corner.0][corner.1] = currentPlayer
                if checkForWinner() {
                    winner = currentPlayer
                    updateScore()
                } else {
                    currentPlayer = "X"
                }
                return true
            }
        }
        return false
    }

    private func makeRandomMove() {
        var emptyCells: [(Int, Int)] = []
        for row in 0..<3 {
            for col in 0..<3 {
                if board[row][col] == "" {
                    emptyCells.append((row, col))
                }
            }
        }
        if let randomCell = emptyCells.randomElement() {
            board[randomCell.0][randomCell.1] = currentPlayer
            if checkForWinner() {
                winner = currentPlayer
                updateScore()
            } else {
                currentPlayer = "X"
            }
        }
    }

    private func blockWinningMove() -> Bool {
        for row in 0..<3 {
            for col in 0..<3 {
                if board[row][col] == "" {
                    board[row][col] = "X" // Assume the player is "X"
                    if checkForWinner() {
                        board[row][col] = "O" // Block the winning move
                        currentPlayer = "X"
                        return true
                    }
                    board[row][col] = "" // Reset
                }
            }
        }
        return false
    }

    private func makeOptimalMove() {
        let (bestRow, bestCol) = minimax(board: board, depth: 0, isMaximizing: true)
        board[bestRow][bestCol] = currentPlayer
        if checkForWinner() {
            winner = currentPlayer
            updateScore()
        } else {
            currentPlayer = "X"
        }
    }

    private func minimax(board: [[String]], depth: Int, isMaximizing: Bool) -> (Int, Int) {
        if let score = evaluateBoard(board: board) {
            return (score, score) // Return score based on winner
        }
        if board.flatMap({ $0 }).allSatisfy({ $0 != "" }) {
            return (0, 0) // Draw
        }

        var bestScore = isMaximizing ? Int.min : Int.max
        var bestMove = (0, 0)

        for row in 0..<3 {
            for col in 0..<3 {
                if board[row][col] == "" {
                    var newBoard = board
                    newBoard[row][col] = isMaximizing ? "O" : "X"
                    let score = minimax(board: newBoard, depth: depth + 1, isMaximizing: !isMaximizing).0

                    if (isMaximizing && score > bestScore) || (!isMaximizing && score < bestScore) {
                        bestScore = score
                        bestMove = (row, col)
                    }
                }
            }
        }
        return bestMove
    }

    private func evaluateBoard(board: [[String]]) -> Int? {
        for i in 0..<3 {
            if board[i][0] == "O" && board[i][1] == "O" && board[i][2] == "O" {
                return 10 // Bot wins
            }
            if board[i][0] == "X" && board[i][1] == "X" && board[i][2] == "X" {
                return -10 // Player wins
            }
            if board[0][i] == "O" && board[1][i] == "O" && board[2][i] == "O" {
                return 10 // Bot wins
            }
            if board[0][i] == "X" && board[1][i] == "X" && board[2][i] == "X" {
                return -10 // Player wins
            }
        }
        if board[0][0] == "O" && board[1][1] == "O" && board[2][2] == "O" {
            return 10 // Bot wins
        }
        if board[0][2] == "X" && board[1][1] == "X" && board[2][0] == "X" {
            return -10 // Player wins
        }
        return nil // No winner yet
    }

    private func checkForWinner() -> Bool {
        for i in 0..<3 {
            if board[i][0] == currentPlayer && board[i][1] == currentPlayer && board[i][2] == currentPlayer {
                return true
            }
            if board[0][i] == currentPlayer && board[1][i] == currentPlayer && board[2][i] == currentPlayer {
                return true
            }
        }
        if board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer {
            return true
        }
        if board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer {
            return true
        }
        return false
    }

    private func updateScore() {
        if winner == "X" {
            xScore += 1
        } else if winner == "O" {
            oScore += 1
        }
    }

    func resetGame() {
        board = [["", "", ""], ["", "", ""], ["", "", ""]]
        currentPlayer = "X"
        winner = nil
    }
}
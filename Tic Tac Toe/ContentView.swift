//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Madi Sharipov on 26.02.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var gameLogic = GameLogic()
    @State private var isTwoPlayerMode: Bool = true // Toggle for game mode

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                Text("Tic Tac Toe")
                    .font(.largeTitle)
                    .padding()

                HStack {
                    Text("X: \(gameLogic.xScore)")
                        .font(.title2)
                        .padding()
                    Spacer()
                    Text("O: \(gameLogic.oScore)")
                        .font(.title2)
                        .padding()
                }

                if let winner = gameLogic.winner {
                    Text("\(winner) wins!")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()
                }

                // Toggle for game mode
                Toggle("Play with Friend", isOn: $isTwoPlayerMode)
                    .padding()
                    .onChange(of: isTwoPlayerMode) { value in
                        gameLogic.isTwoPlayerMode = value
                        gameLogic.resetGame() // Reset the game when changing modes
                    }

                // Difficulty level picker
                if !isTwoPlayerMode {
                    Picker("Bot Level", selection: $gameLogic.botLevel) {
                        ForEach(BotLevel.allCases, id: \.self) { level in
                            Text(level.rawValue).tag(level)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                    ForEach(0..<3) { row in
                        ForEach(0..<3) { col in
                            Button(action: {
                                gameLogic.makeMove(row: row, col: col)
                            }) {
                                Text(gameLogic.board[row][col])
                                    .font(.system(size: 60))
                                    .frame(width: 100, height: 100)
                                    .background(Color.blue.opacity(0.7))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .animation(.easeInOut)
                            }
                            .disabled(gameLogic.board[row][col] != "" || gameLogic.winner != nil)
                        }
                    }
                }
                .padding()

                Button(action: gameLogic.resetGame) {
                    Text("Reset Game")
                        .font(.title2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Tic Tac Toe")
            .onAppear(perform: gameLogic.resetGame)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

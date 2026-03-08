//
//  GameModel.swift
//  TicTacToe
//
//  Created by Michael Peralta on 3/6/26.
//

import Foundation

struct GameModel {
    enum Turn {
        case Nought
        case Cross
    }
    private(set) var board: [String?] = Array(repeating: nil, count: 9)
    private(set) var currentTurn: Turn = .Cross
    private(set) var firstTurn: Turn = .Cross

    static let noughtSymbol = "O"
    static let crossSymbol = "X"

    var noughtsScore: Int = 0
    var crossesScore: Int = 0

    var isBoardFull: Bool { board.allSatisfy { $0 != nil } }

    /// All 8 winning lines as triples of board indices (order: a1,a2,a3, b1,b2,b3, c1,c2,c3 → 0...8)
    private static let winLines: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],  // rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8],  // columns
        [0, 4, 8], [2, 4, 6],  // diagonals
    ]

    func symbol(for turn: Turn) -> String {
        switch turn {
        case .Cross: return Self.crossSymbol
        case .Nought: return Self.noughtSymbol
        }
    }

    mutating func play(at index: Int) -> Bool {
        guard board.indices.contains(index), board[index] == nil else {
            return false
        }
        board[index] = symbol(for: currentTurn)
        currentTurn = (currentTurn == .Cross) ? .Nought : .Cross
        return true
    }

    mutating func resetForNewGame() {
        board = Array(repeating: nil, count: 9)
        firstTurn = firstTurn == .Nought ? .Cross : .Nought
        currentTurn = firstTurn
    }

    func checkForVictory(for player: String) -> Bool {
        for line in Self.winLines {
            let a = board[line[0]]
            let b = board[line[1]]
            let c = board[line[2]]
            if a == player && b == player && c == player {
                return true
            }
        }
        return false
    }

}

//
//  ViewController.swift
//  TicTacToe
//
//  Created by Michael Peralta on 3/5/26.
//

import UIKit

class ViewController: UIViewController {

    var gameModel = GameModel()

    @IBOutlet weak var turnLabel: UILabel!

    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!

    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!

    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!

    var board = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        board = [a1, a2, a3, b1, b2, b3, c1, c2, c3]
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)

        if gameModel.checkForVictory(for: GameModel.crossSymbol) {
            gameModel.crossesScore += 1
            resultAlert(title: "Crosses Win!")
        } else if gameModel.checkForVictory(for: GameModel.noughtSymbol) {
            gameModel.noughtsScore += 1
            resultAlert(title: "Noughts Win!")
        } else if gameModel.isBoardFull {
            resultAlert(title: "Draw")
        }
    }

    func resultAlert(title: String) {
        setBoardEnabled(false)
        let message =
            "\nNoughts " + String(gameModel.noughtsScore) + "\nCrosses "
            + String(gameModel.crossesScore)
        let ac = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        ac.addAction(
            UIAlertAction(
                title: "Reset",
                style: .default,
                handler: { (_) in
                    self.gameModel.resetForNewGame()
                    self.clearBoard()
                    self.turnLabel.text = self.gameModel.symbol(
                        for: self.gameModel.currentTurn
                    )
                }
            )
        )
        self.present(ac, animated: true, completion: nil)
    }

    func addToBoard(_ sender: UIButton) {
        guard let index = board.firstIndex(of: sender) else { return }
        guard gameModel.play(at: index) else { return }

        sender.setTitle(gameModel.board[index], for: .normal)
        sender.isEnabled = false
        turnLabel.text = gameModel.symbol(for: gameModel.currentTurn)
    }
    
    func setBoardEnabled(_ enabled: Bool) {
        for button in board {
            button.isEnabled = enabled
        }
    }
    
    func clearBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
    }
}

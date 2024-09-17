//
//  ViewController.swift
//  ticTacToe
//
//  Created by Linus Karlsson on 2024-09-13.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet var gameBtnCollection: [UIButton]!
    @IBOutlet weak var turnWinLabel: UILabel!
    @IBOutlet weak var activePlayer: UILabel!
    
    enum Turn {
        case cross
        case circle
    }
    
    let startingPlayer = Turn.cross
    var currentPlayer = Turn.cross
    
    let crossSymbol = "X"
    let circleSymbol = "O"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activePlayer.text = "\(currentPlayer == .cross ? crossSymbol : circleSymbol)'s Turn"
    }
    
    @IBAction func gridPress(_ sender: UIButton) {
        guard let buttonIndex = gameBtnCollection.firstIndex(of: sender) else {
            print("Button missing")
            return
        }
        
        if sender.currentTitle == nil {
            sender.setTitle(currentPlayer == .cross ? crossSymbol : circleSymbol, for: .normal)
            
            if winConditions() {
                activePlayer.text = "\(currentPlayer == .cross ? crossSymbol : circleSymbol) Wins!"
                gameBtnCollection.forEach { $0.isUserInteractionEnabled = false }
            } else if gameBtnCollection.allSatisfy({ $0.currentTitle != nil }) {
                activePlayer.text = "It's a tie!"
            } else {
                currentPlayer = (currentPlayer == .cross) ? .circle : .cross
                activePlayer.text = "\(currentPlayer == .cross ? crossSymbol : circleSymbol)'s Turn"
            }
        }
    }
    
    func winConditions() -> Bool {
        let winPatterns: [[Int]] = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
        ]
        
        for pattern in winPatterns {
            let titles = pattern.map { gameBtnCollection[$0].currentTitle }
            if titles.allSatisfy({ $0 == crossSymbol }) || titles.allSatisfy({ $0 == circleSymbol }) {
                return true
            }
        }
        return false
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        gameBtnCollection.forEach { button in
            button.setTitle(nil, for: .normal)
            button.isUserInteractionEnabled = true
        }
        currentPlayer = startingPlayer
        activePlayer.text = "\(currentPlayer == .cross ? crossSymbol : circleSymbol)'s Turn"
    }
}

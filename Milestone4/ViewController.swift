//
//  ViewController.swift
//  Milestone4
//
//  Created by Rosalyn Kingsmill on 2017-08-06.
//  Copyright © 2017 Rosalyn Kingsmill. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var wrongTrys: UILabel!
    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var lettersGuessed: UILabel!
    
    var wrongCount: Int = 0 {
        didSet {
            wrongTrys.text = "Wrong Guesses:\n\(wrongCount)"
        }
    }
    var hangmanWords = [String]()
    var chosenWord = String()
    var usedLetters: [String] = [] {
        didSet {
            lettersGuessed.text = "Letters Guessed:\n\(usedLetters.joined)"
        }
    }
    
    var scoreCount: Int = 0 {
        didSet {
            score.text = "Score: \(scoreCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let file = Bundle.main.path(forResource: "hangman", ofType: "txt") {
            if let content = try? String(contentsOfFile:file) {
                hangmanWords = content.components(separatedBy: "\n")
            } else {
                loadDefaultWords()
            }
        } else {
            loadDefaultWords()
        }
        hangmanWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: hangmanWords) as! [String]
        startGame()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadDefaultWords() {
        hangmanWords = ["pumpkin"]
    }
    
    func startGame() {
        //reset wrong trys and letters guessed
        scoreCount = 0
        wrongCount = 0
        usedLetters = []
        chosenWord = hangmanWords[0]
        word.text = ""
        //append a ? for every letter in the word
        for _ in chosenWord.characters {
           word.text?.append("?")
        }
    }
    
    @IBAction func guess(_ sender: Any) {
        let ac = UIAlertController(title: "Guess Letter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let go = UIAlertAction(title: "Go", style: .default) { [unowned self, ac] (action: UIAlertAction) in
            
            //check if right or wrong
            if let charEntered = ac.textFields?[0].text {
                let entered = charEntered
                if (entered.characters.count) == 1 {
                    if !self.usedLetters.contains(entered) {
                        if (self.chosenWord).contains(entered){
                            self.check(Letter:entered)
                            return
                        } else {
                            self.display(ErrorMessage: "Guess Again")
                        }
                    } else {
                        self.display(ErrorMessage: "You already guessed that one")
                    }
                } else {
                    self.display(ErrorMessage: "You can only enter one letter at a time")
                }
            } else {
                self.display(ErrorMessage: "You must enter a letter to guess")
            }
        }
        ac.addAction(go)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func check(Letter letter:String) {
        //check if in string
        var promptWord = ""
        if chosenWord.contains(letter){
            //update guessed
            usedLetters.append(letter)
            //update word
            for (letter) in chosenWord.characters {
                let strLetter = String(letter)
                if usedLetters.contains(strLetter){
                    promptWord += strLetter
                } else {
                    promptWord += "?"
                }
                word.text = promptWord
            }

        } else {
            //update guessed
            usedLetters.append(letter)
            //update wrong
            wrongCount += 1
        }
    }
    func display(ErrorMessage errorMessage: String) {
        let errorAC = UIAlertController(title: errorMessage, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel)
        errorAC.addAction(cancel)
        present(errorAC, animated: true)
    }

}


//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chooseWord: UITextField!
    @IBOutlet weak var guessedWord: UILabel!
    @IBOutlet weak var hangmanPictures: UIImageView!
    @IBOutlet weak var whatToDoLabel: UILabel!
    @IBOutlet weak var inputLetter: UITextField!
    
    
    
    var hangman = HangmanBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseWord.delegate = self
        inputLetter.delegate = self
        inputLetter.isEnabled = false
        hangmanPictures.image = UIImage(named: HangmanImages.defaultImage)
        restartGame()
        
    }
    func restartGame() {
        hangman = HangmanBrain()
        chooseWord.text = ""
        chooseWord.isEnabled = true
        guessedWord.text = ""
        hangmanPictures.image = UIImage(named: HangmanImages.defaultImage)
        inputLetter.isEnabled = false
        whatToDoLabel.text = "Enter a letter"
    }
    
    
    
    
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        hangman.userInputWord = chooseWord.text!.uppercased()
        hangman.userInputLetter = inputLetter.text!.uppercased()
        var word = ""
        for _ in 0..<hangman.userInputWord.count {
            word +=  " _ "
        }
        guessedWord.text = word
        chooseWord.isEnabled = false
        inputLetter.isEnabled = true
        
        if textField == inputLetter {
            if !hangman.guessedLetters.contains(hangman.userInputLetter) {
                if hangman.checkingWord(userWordInput: hangman.userInputWord, userWordGuess: hangman.userInputLetter) == true {
                    whatToDoLabel.text = "You guessed correctly"
                } else {
                    whatToDoLabel.text = "You guessed incorrectly"
                }
            } else {
                whatToDoLabel.text = "You already guessed that letter"
                textField.text = ""
            }
            
            textField.text = ""
            guessedWord.text = hangman.replaceDashes(word: hangman.userInputWord)
            
            
            
            if hangman.correctGuesses == hangman.userInputWord.count {
                whatToDoLabel.text = "You win, the word is \(hangman.userInputWord)"
                inputLetter.isEnabled = false
            } else if hangman.wrongGuesses > 0 && hangman.wrongGuesses < 6 {
                switch hangman.wrongGuesses {
                case 1:
                    hangmanPictures.image = UIImage(named: HangmanImages.firstWrongGuess)
                case 2:
                    hangmanPictures.image = UIImage(named: HangmanImages.secondWrongGuess)
                case 3:
                    hangmanPictures.image = UIImage(named: HangmanImages.thirdWrongGuess)
                case 4:
                    hangmanPictures.image = UIImage(named: HangmanImages.fourthWrongGuess)
                case 5:
                    hangmanPictures.image = UIImage(named: HangmanImages.fifthWrongGuess)
                default:
                    hangmanPictures.image = UIImage(named: "Default Image")
                }
            } else if hangman.wrongGuesses == 6 {
                hangmanPictures.image = UIImage(named: HangmanImages.sixthWrongGuess)
                whatToDoLabel.text = "You lose, the word is \(hangman.userInputWord)"
                inputLetter.isEnabled = false
            }
        }
        
        
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string.rangeOfCharacter(from: CharacterSet.letters) != nil) || (string == "" && range.length > 0) {
            
            return inputLetter.text!.count < 1
        } else {
            whatToDoLabel.text = "Enter alphabets only"
            return false
        }
    }


  
    
}

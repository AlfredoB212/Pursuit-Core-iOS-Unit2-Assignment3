//
//  Hangman.swift
//  Hangman
//
//  Created by Alfredo Barragan on 11/26/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

struct HangmanImages {
    static let defaultImage = "hang1"
    static let firstWrongGuess = "hang2"
    static let secondWrongGuess = "hang3"
    static let thirdWrongGuess = "hang4"
    static let fourthWrongGuess = "hang5"
    static let fifthWrongGuess = "hang6"
    static let sixthWrongGuess = "hang7"
}


class HangmanBrain {
    var guessedLetters = [String]()
    var userInputWord: String = ""
    var userInputLetter: String = ""
    var correctLetter: String = ""
    var guessingWord: String = ""
    var wrongGuesses: Int = 0
    var correctGuesses: Int = 0
    var gameOverImage = UIImage(named: HangmanImages.sixthWrongGuess)!
    var gameDone: Bool = false
    
    
    func checkingWord (userWordInput: String, userWordGuess: String) -> Bool {
        var rightGuess = Bool()
        guessedLetters.append(userInputLetter)
        if userWordInput.contains(userWordGuess) {
            rightGuess = true
            let capChar = Character(userWordGuess)
            for letter in userWordInput {
                switch letter {
                case capChar:
                    correctGuesses += 1
                    correctLetter.append(userWordGuess)
                default:
                    continue
                }
            }
        } else {
            wrongGuesses += 1
            rightGuess = false
        }
        return rightGuess
    }
    
    func replaceDashes (word: String) -> String {
        var replacingString = String()
        for letter in word {
            if correctLetter.contains(letter) {
                replacingString += String(letter)
            } else {
                replacingString += "_"
            }
            replacingString += "_"
        }
        return replacingString
    }
    
}

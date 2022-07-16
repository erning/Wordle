//
//  GameViewModel.swift
//  Wordle
//
//  Created by Zhang Erning on 7/15/22.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    var answer: [Character]

    @Published
    var toastMessage: String = ""

    @Published
    var showToast: Bool = false

    @Published
    var previousGuesses: [Guess] = []

    @Published
    var currentGuess: [Character] = []

    @Published
    var usedLetters: [Character: Correctness] = [:]

    @Published
    var shakeCurrentGuess: Int = 0

    init(answer: [Character]) {
        self.answer = answer
    }

    convenience init() {
        guard let answer = WordBank.answers.randomElement() else {
            self.init(answer: Array("HELLO"))
            return
        }
        print(answer)
        self.init(answer: Array(answer))
    }
}

extension GameViewModel {
    var isGameOver: Bool {
        previousGuesses.count >= MAX_NUMBER_OF_GUESS
    }

    var isWin: Bool {
        guard let guess = previousGuesses.last else {
            return false
        }
        return guess.mask.allSatisfy({ $0 == .correct })
    }
}

extension GameViewModel {
    func keyPressed(_ key: Keycap) {
        if isGameOver || isWin {
            return
        }
        switch key {
        case .letter(let ch):
            guard currentGuess.count < LENGTH_OF_WORD else {
                return
            }
            currentGuess.append(ch)
        case .delete:
            guard currentGuess.count > 0 else {
                return
            }
            _ = currentGuess.popLast()
        case .enter:
            guard currentGuess.count == LENGTH_OF_WORD else {
                toast(message: "Not enough letters")
                shake()
                return
            }
            guard WordBank.dictionary.contains(String(currentGuess)) else {
                toast(message: "Not in word list")
                shake()
                return
            }
            let guess = Guess.compute(currentGuess, against: answer)
            updateUsedLetters(guess)
            previousGuesses.append(guess)
            currentGuess.removeAll()
        }
    }

    func toast(message: String) {
        toastMessage = message
        showToast = true
    }

    func shake() {
        withAnimation {
            shakeCurrentGuess += 1
        }
    }

    func updateUsedLetters(_ guess: Guess) {
        for (letter, correctness) in zip(guess.word, guess.mask) {
            if usedLetters[letter] != .correct {
                usedLetters[letter] = correctness
            }
        }
    }
}


enum Keycap {
    case letter(Character)
    case delete
    case enter
}

extension Keycap: Identifiable {
    var id: Character {
        switch self {
        case .delete:
            return "d"
        case .enter:
            return "e"
        case .letter(let ch):
            return ch
        }
    }
}

// MARK: -

extension GameViewModel {
    static let preview: GameViewModel = {
        let preview = GameViewModel()
        preview.previousGuesses.append(Guess.compute("HELLO", against: "WORLD"))
        preview.previousGuesses.append(Guess.compute("WATER", against: "WORLD"))
        preview.currentGuess = Array("WRI")
        return preview
    }()
}

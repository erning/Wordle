//
//  Wordle.swift
//  Wordle
//
//  Created by Zhang Erning on 7/15/22.
//

import Foundation

let MAX_NUMBER_OF_GUESS = 6
let LENGTH_OF_WORD = 5

class WordBank {
    static let bundle = Bundle(for: WordBank.self)

    static let answers: [String] = {
        guard let filepath = bundle.path(forResource: "answers", ofType: "txt") else {
            // TODO: file not found
            return []
        }
        do {
            let contents = try String(contentsOfFile: filepath)
            return contents
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: .newlines)
                .filter { $0.count == LENGTH_OF_WORD }
                .map { $0.uppercased() }
        } catch {
            // TODO: parse error
            return []
        }
    }()

    static let dictionary: Set<String> = {
        guard let filepath = bundle.path(forResource: "wordbank", ofType: "txt") else {
            // TODO: file not found
            return Set()
        }
        do {
            let contents = try String(contentsOfFile: filepath)
            return Set(
                contents
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .components(separatedBy: .newlines)
                    .map { $0.split(separator: " ")[0] }
                    .filter { $0.count == LENGTH_OF_WORD }
                    .map { $0.uppercased() }
            )
        } catch {
            // TODO: parse error
            return Set()
        }
    }()
}

enum Correctness {
    case correct, misplaced, wrong
}

struct Guess {
    var word: [Character]
    var mask: [Correctness]

    static func compute(_ word: [Character], against answer: [Character]) -> Guess {
        assert(answer.count == LENGTH_OF_WORD)
        assert(answer.allSatisfy({ $0.isUppercase }))
        let count = LENGTH_OF_WORD

        var mask = [Correctness](repeating: .wrong, count: count)
        var used = [Bool](repeating: false, count: count)
        for i in 0 ..< count {
            if word[i] == answer[i] {
                mask[i] = .correct
                used[i] = true
            }
        }
        for i in 0 ..< count {
            if mask[i] == .correct {
                continue
            }
            for j in 0..<count {
                if word[i] == answer[j] && used[j] == false {
                    mask[i] = .misplaced
                    used[j] = true
                    break
                }
            }
        }
        return Guess(word: word, mask: mask)
    }

    static func compute(_ word: String, against answer: String) -> Guess {
        return compute(Array(word), against: Array(answer))
    }
}

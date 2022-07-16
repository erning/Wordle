//
//  BoardView.swift
//  Wordle
//
//  Created by Zhang Erning on 7/15/22.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject
    var model: GameViewModel
    
    var body: some View {
        VStack {
            ForEach(0..<MAX_NUMBER_OF_GUESS, id: \.self) { i in
                guessView(i)
            }
        }
    }

    @ViewBuilder
    func guessView(_ i: Int) -> some View {
        if i < model.previousGuesses.count - 1 {
            let guess = model.previousGuesses[i]
            GuessView(word: guess.word, mask: guess.mask)
        } else if i == model.previousGuesses.count - 1 {
            let guess = model.previousGuesses[i]
            GuessView(word: guess.word, mask: guess.mask, flip: true)
        } else if i == model.previousGuesses.count {
            GuessView(word: model.currentGuess)
                .modifier(
                    ShakeEffect(animatableData: CGFloat(model.shakeCurrentGuess))
                )
        } else {
            GuessView()
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
            .environmentObject(GameViewModel.preview)
    }
}

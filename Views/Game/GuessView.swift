//
//  GuessView.swift
//  Wordle
//
//  Created by Zhang Erning on 7/15/22.
//

import SwiftUI

struct GuessView: View {
    var word: [Character] = []
    var mask: [Correctness] = []
    var flip: Bool = false

    var body: some View {
        HStack {
            ForEach(0..<LENGTH_OF_WORD, id: \.self) { i in
                if flip {
                    FlipView(
                        SpotView(letter: letter(i)),
                        SpotView(letter: letter(i), correctness: correctness(i)),
                        delay: 0.5 * TimeInterval(i)
                    )
                } else {
                    SpotView(letter: letter(i), correctness: correctness(i))
                }
            }
        }
    }

    func letter(_ i: Int) -> Character? {
        i < word.count ? word[i] : nil
    }

    func correctness(_ i: Int) -> Correctness? {
        i < mask.count ? mask[i] : nil
    }
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView()
    }
}

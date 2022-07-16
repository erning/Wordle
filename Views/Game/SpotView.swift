//
//  SpotView.swift
//  Wordle
//
//  Created by Zhang Erning on 7/15/22.
//

import SwiftUI

struct SpotView: View {
    var letter: Character?
    var correctness: Correctness?

    @State
    var scale = 1.0

    var body: some View {
        Text(letterText)
            .font(.system(size: 36, weight: .heavy))
            .frame(minWidth: 60, minHeight: 60)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .border(borderColor)
            .scaleEffect(scale)
            .onChange(of: letter) { newValue in
                if newValue != nil {
                    withAnimation(Animation.linear(duration: 0.1)) {
                        scale = 1.2
                    }
                    withAnimation(Animation.linear(duration: 0.2).delay(0.1)) {
                        scale = 1.0
                    }
                }
            }
    }

    var letterText: String {
        if let letter = letter {
            return String(letter)
        } else {
            return ""
        }
    }

    var foregroundColor: Color {
        if letter == nil || correctness == nil {
            return ColorAssets.foreground
        } else {
            return ColorAssets.maskForeground
        }
    }

    var backgroundColor: Color {
        if letter == nil {
            return ColorAssets.spotBackground
        }
        switch correctness {
        case .correct:
            return ColorAssets.maskCorrect
        case .misplaced:
            return ColorAssets.maskMisplaced
        case .wrong:
            return ColorAssets.maskWrong
        default:
            return ColorAssets.spotBackground
        }
    }

    var borderColor: Color {
        if correctness != nil {
            return Color.clear
        }
        if letter == nil {
            return ColorAssets.spotBorder
        } else {
            return ColorAssets.spotBorderOccupied
        }
    }
}

struct SpotView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                SpotView(letter: "H", correctness: .correct)
                SpotView(letter: "E", correctness: .misplaced)
                SpotView(letter: "L", correctness: .correct)
                SpotView(letter: "L")
                SpotView()
            }
            HStack {
                SpotView()
                SpotView()
                SpotView()
                SpotView()
                SpotView()
            }
        }
    }
}

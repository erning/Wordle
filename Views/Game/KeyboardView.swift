//
//  KeyboardView.swift
//  Wordle
//
//  Created by Zhang Erning on 7/15/22.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject
    var model: GameViewModel

    static let keycaps: [[Keycap]] = {
        return ["QWERTYUIOP", "ASDFGHJKL", "eZXCVBNMd"]
            .map { row in
                row.map { ch -> Keycap in
                    switch ch {
                    case "e":
                        return .enter
                    case "d":
                        return .delete
                    default:
                        return .letter(ch)
                    }
                }
            }
    }()

    var body: some View {
        VStack(spacing: 4) {
            ForEach(0..<3) { i in
                HStack(spacing: 4) {
                    ForEach(Self.keycaps[i]) { keycap in
                        Button(action: {
                            model.keyPressed(keycap)
                        }) {
                            keycapLabel(keycap)
                        }
                        .buttonStyle(keycapStyle(keycap))
                        .disabled(model.showToast)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func keycapLabel(_ keycap: Keycap) -> some View {
        switch keycap {
        case .delete:
            Image(systemName: "delete.left")
        case .enter:
            Text("ENTER")
        case .letter(let ch):
            Text(String(ch))
        }
    }

    func keycapStyle(_ keycap: Keycap) -> some ButtonStyle {
        let correctness: Correctness? = {
            if case .letter(let letter) = keycap {
                return model.usedLetters[letter]
            }
            return nil
        }()
        return KeycapButtonStyle(correctness: correctness)
    }

    struct KeycapButtonStyle: ButtonStyle {
        var correctness: Correctness?

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .padding(.horizontal, 5)
                .foregroundColor(foregroundColor)
                .frame(minWidth: 30, minHeight: 40)
                .background(backgroundColor)
                .cornerRadius(4)
                .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
        }

        var foregroundColor: Color {
            if correctness == nil {
                return ColorAssets.foreground
            } else {
                return ColorAssets.maskForeground
            }
        }

        var backgroundColor: Color {
            switch correctness {
            case .correct:
                return ColorAssets.maskCorrect
            case .misplaced:
                return ColorAssets.maskMisplaced
            case .wrong:
                return ColorAssets.maskWrong
            default:
                return ColorAssets.keycapBackground}
        }
    }
}

// MARK: -

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .environmentObject(GameViewModel.preview)
    }
}

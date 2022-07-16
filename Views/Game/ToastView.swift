//
//  ToastView.swift
//  Wordle
//
//  Created by Zhang Erning on 7/15/22.
//

import SwiftUI

struct ToastView: View {
    var message: String
    @Binding var isShowing: Bool
    var durian: TimeInterval = 1.0

    var body: some View {
        if isShowing {
            DispatchQueue.main.asyncAfter(deadline: .now() + durian) {
                withAnimation {
                    self.isShowing = false
                }
            }
        }

        return Text(message)
            .font(.headline)
            .foregroundColor(ColorAssets.background)
            .padding(.horizontal, 25)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(ColorAssets.foreground.opacity(0.9))
            )
            .opacity(isShowing ? 1.0 : 0.0)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: "Not enough letters", isShowing: .constant(true))
    }
}

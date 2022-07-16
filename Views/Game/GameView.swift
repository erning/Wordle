//
//  GameView.swift
//  Wordle
//
//  Created by Zhang Erning on 7/15/22.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var model: GameViewModel
    @State var showToastMessage: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Color.clear.frame(height: 30)
            BoardView()
            KeyboardView()
        }
        .overlay(alignment: .top) {
            ToastView(message: model.toastMessage, isShowing: $model.showToast)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameViewModel.preview)
    }
}

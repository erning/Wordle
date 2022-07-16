//
//  FlipView.swift
//  Wordle
//
//  Created by Zhang Erning on 7/15/22.
//

import SwiftUI

struct FlipView<ContentA: View, ContentB: View>: View {
    var a: ContentA
    var b: ContentB
    var delay: TimeInterval

    @State private var flipped: Bool = false
    @State private var r1 = 0.0
    @State private var r2 = 0.0

    init(_ a: ContentA, _ b: ContentB, delay: TimeInterval) {
        self.a = a
        self.b = b
        self.delay = delay
    }

    var body: some View {
        ZStack {
            if flipped { b } else { a }
        }
        .rotation3DEffect(.degrees(r1), axis: (x: 1, y: 0, z: 0))
        .rotation3DEffect(.degrees(r2), axis: (x: 1, y: 0, z: 0))
        .onAppear() {
            let animationTime = 0.5
            withAnimation(Animation.linear(duration: animationTime).delay(delay)) {
                r2 += -180
            }
            withAnimation(Animation.linear(duration: 0.001).delay(delay + animationTime / 2)) {
                flipped.toggle()
                r1 += -180
            }
        }
    }
}

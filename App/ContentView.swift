//
//  ContentView.swift
//  Shared
//
//  Created by Zhang Erning on 7/14/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameView()
            .environmentObject(GameViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

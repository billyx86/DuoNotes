//
//  ContentView.swift
//  DuoNotes
//
//  Created by billyking on 25/10/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            Text("Flashcards")
                .font(.largeTitle)
        } else {
            Text("Notes")
                .font(.largeTitle)
        }
    }
}

#Preview {
    ContentView()
}

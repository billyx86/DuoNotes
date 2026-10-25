//
//  ContentView.swift
//  DuoNotes
//
//  Created by billyking on 25/10/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            CardListView()
        } else {
            Text("Notes")
                .font(.largeTitle)
        }
    }
}

struct CardListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Flashcard.createdAt) private var cards: [Flashcard]
    
    var body: some View {
        NavigationStack {
            List(cards) { card in
                VStack(alignment: .leading) {
                    Text(card.front).bold()
                    Text(card.back).foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Cards (\(cards.count))")
            .toolbar {
                Button("Add", systemImage: "plus") {
                    context.insert(Flashcard(front: "Question \(cards.count + 1)", back: "Answer"))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

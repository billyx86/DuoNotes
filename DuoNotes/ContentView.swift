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
    @State private var isReviewing = false
    @State private var editingCard: Flashcard?
    
    var body: some View {
        NavigationStack {
            List(cards) { card in
                VStack(alignment: .leading) {
                    Text(card.front).bold()
                    Text(card.back).foregroundStyle(.secondary)
                }
                .contentShape(.rect)
                .onTapGesture { editingCard = card }
            }
            .navigationTitle("Cards (\(cards.count))")
            .toolbar {
                Button("Add", systemImage: "plus") {
                    let card = Flashcard(front: "", back: "")
                    context.insert(card)
                    editingCard = card
                }
                Button("Review", systemImage: "rectangle.on.rectangle.angled") {
                    isReviewing = true
                }
                .navigationDestination(isPresented: $isReviewing) {
                    ReviewView(cards: cards)
                }
                .sheet(item: $editingCard) { card in
                    CardEditorView(card: card)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

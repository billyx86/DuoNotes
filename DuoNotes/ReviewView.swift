//
//  ReviewView.swift
//  DuoNotes
//
//  Created by billyking on 25/10/2026.
//

import SwiftUI
import SwiftData

struct ReviewView: View {
    let cards: [Flashcard]
    @State private var index = 0
    @State private var showBack = false
    
    var body: some View {
        if index < cards.count {
            let card = cards[index]
            VStack(spacing: 20) {
                Text("\(index + 1) of \(cards.count)")
                    .foregroundStyle(.secondary)
                
                Text(showBack ? card.back : card.front)
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(showBack ? Color.green.opacity(0.15) : Color.blue.opacity(0.15),
                                in: .rect(cornerRadius: 20))
                    .rotation3DEffect(.degrees(showBack ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                    .scaleEffect(x: showBack ? -1 : 1)
                    .onTapGesture {
                        withAnimation(.spring) { showBack.toggle() }
                    }
                
                HStack {
                    Button("Didn't know", systemImage: "xmark") { answer(false) }
                        .tint(.red)
                    Button("Knew it", systemImage: "checkmark") { answer(true) }
                        .tint(.green)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        } else {
            ContentUnavailableView("Deck done! 🎉", systemImage: "checkmark.seal",
                                   description: Text("\(cards.filter(\.isKnown).count) of \(cards.count) known"))
        }
    }
    
    private func answer(_ known: Bool) {
        cards[index].isKnown = known
        showBack = false
        index += 1
    }
}

//
//  CardEditorView.swift
//  DuoNotes
//
//  Created by billyking on 25/10/2026.
//

import SwiftUI
import SwiftData

struct CardEditorView: View {
    @Bindable var card: Flashcard
    var isNew: Bool = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var originalFront = ""
    @State private var originalBack = ""

    private var isEmpty: Bool {
        card.front.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        card.back.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Question") {
                    TextField("Front of card", text: $card.front, axis: .vertical)
                }
                Section("Answer") {
                    TextField("Back of card", text: $card.back, axis: .vertical)
                }
            }
            .navigationTitle(isNew ? "New Card" : "Edit Card")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", systemImage: "checkmark") { dismiss() }
                        .disabled(isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") { cancel() }
                }
                
            }
            .interactiveDismissDisabled(isEmpty)
            .onAppear {
                originalFront = card.front
                originalBack = card.back
            }
        }
    }

    private func cancel() {
        if isNew {
            context.delete(card)
        } else {
            card.front = originalFront
            card.back = originalBack
        }
        dismiss()
    }
}

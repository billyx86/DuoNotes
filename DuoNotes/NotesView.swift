//
//  NotesView.swift
//  DuoNotes
//
//  Created by billyking on 25/10/2026.
//

import SwiftUI
import SwiftData

struct NotesView: View {    @Environment(\.modelContext) private var context
    @Query(sort: \Note.createdAt, order: .reverse) private var notes: [Note]
    @State private var selected: Note?
    var body: some View {
        
        NavigationSplitView {
            List(notes, selection: $selected) { note in
                Text(note.title.isEmpty ? "Untitled Note" : note.title)
                    .tag(note)
            }
            .navigationTitle("Notes")
            .toolbar {
                Button("New Note", systemImage: "square.and.pencil") {
                    let note = Note()
                    context.insert(note)
                    selected = note
                }
            }
        } detail: {
            if let note = selected {
                NoteDetailView(note: note)
            } else {
                ContentUnavailableView("Pick a note", systemImage: "note.text")
            }
        }
    }
}

struct NoteDetailView: View {
    @Bindable var note: Note
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Title", text: $note.title)
                .font(.title.bold())
            TextEditor(text: $note.body)
        }
        .padding()
    }
}

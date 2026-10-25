//
//  DuoNotesApp.swift
//  DuoNotes
//
//  Created by billyking on 25/10/2026.
//

import SwiftUI
import SwiftData

@main
struct DuoNotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Flashcard.self, Note.self])
    }
}

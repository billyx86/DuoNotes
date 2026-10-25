//
//  Flashcard.swift
//  DuoNotes
//
//  Created by billyking on 25/10/2026.
//

import Foundation
import SwiftData

@Model
final class Flashcard {
    var front: String
    var back: String
    var createdAt: Date
    
    init(front: String, back: String) {
        self.front = front
        self.back = back
        self.createdAt = .now
    }
}

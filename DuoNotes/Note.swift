//
//  Note.swift
//  DuoNotes
//
//  Created by billyking on 25/10/2026.
//

import Foundation
import SwiftData

@Model
final class Note {
    var title: String = ""
    var body: String = ""
    var createdAt: Date = Date.now
    
    init(title: String = "", body: String = "") {
        self.title = title
        self.body = body
    }
}

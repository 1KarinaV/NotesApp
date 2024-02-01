//
//  Note.swift
//  NotesApp
//
//  Created by Карина Владыкина on 27.01.2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Note {
    var content: String
    var category: NoteCategory?
    var isFavourite: Bool = false

    init(content: String, category: NoteCategory? = nil) {
        self.content = content
        self.category = category
        self.isFavourite = isFavourite
    }
}

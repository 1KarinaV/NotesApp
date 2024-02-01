//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by Карина Владыкина on 27.01.2024.
//

import SwiftUI

@main
struct NotesAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 320, minHeight: 400)
        }
        .windowResizability(.contentSize)
        //Data Model
        .modelContainer(for: [Note.self, NoteCategory.self])
    }
}

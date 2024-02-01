//
//  NoteDetailView.swift
//  NotesApp
//
//  Created by Карина Владыкина on 30.01.2024.
//

import SwiftUI


struct NoteDetailView: View {
    @Bindable var note: Note
    var isKeyboardEnabled: FocusState<Bool>.Binding
    
    var body: some View {
        VStack{
            TextEditor(text: $note.content)
                .focused(isKeyboardEnabled)
                .padding(15)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    isKeyboardEnabled.wrappedValue = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

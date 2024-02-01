//
//  NotesView.swift
//  NotesApp
//
//  Created by Карина Владыкина on 27.01.2024.
//

import SwiftUI
import SwiftData

struct NotesView: View {
    
    var category: String?
    
    @Query private var notes: [Note]
    init(category: String? ) {
        self.category = category
        
        let predicate = #Predicate<Note> {
            return $0.category?.categoryTitle == category
        }
        
        let favouritePredicate = #Predicate<Note> {
            return $0.isFavourite
        }
        
        let finalPredicate = category == "All Notes" ? nil : (category == "Favourites" ? favouritePredicate : predicate)
        
        _notes = Query(filter: finalPredicate, sort: [], animation: .snappy)
        
    }
    
    @FocusState private var isKeyboardEnabled: Bool
    @Environment(\.modelContext) private var context
    var body: some View {
        NavigationView {
            GeometryReader{
                let size = $0.size
                let width = size.width
                
                let rowCount = max(Int(width / 250), 1)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: rowCount), spacing: 10) {
                        ForEach(notes) { note in
                            NoteCardView(note: note, isKeyboardEnabled: $isKeyboardEnabled)
                                .contextMenu {
                                    Button(note.isFavourite ? "Remove from Favourites" : "Add to Favourites"){
                                        note.isFavourite.toggle()
                                    }
                                    
                                    Button("Delete", role: .destructive){
                                        context.delete(note)
                                    }
                                }
                        }
                    }
                    .padding(12)
                }
                
                //Closing TextField when tapped outside
                .onTapGesture {
                    isKeyboardEnabled = false
                }
            }
        }
    }
}

struct NoteCardView: View {
    @State private var showNote: Bool = false
    @Bindable var note: Note
    var isKeyboardEnabled: FocusState<Bool>.Binding
    var body: some View {
        NavigationLink(destination: NoteDetailView(note: note, isKeyboardEnabled: isKeyboardEnabled)) {
            
            ZStack{
                Rectangle()
                    .fill(.clear)
                
                if showNote {
                    VStack(alignment: .leading, spacing: 8){
                        Text(note.content.prefix(40))
                            .lineLimit(3)
                            .foregroundColor(.primary)
                    }
                    TextEditor(text: $note.content)
                        .focused(isKeyboardEnabled)
                        .overlay(alignment: Alignment.leading, content: {
                            Text("My Note")
                                .foregroundStyle(.gray)
                                .padding(.leading, 5)
                                .opacity(note.content.isEmpty ? 1 : 0)
                                .allowsHitTesting(false)
                        })
                        .scrollContentBackground(.hidden)
                        .multilineTextAlignment(.leading)
                        .padding(15)
                        .kerning(1.2)
                        .frame(maxWidth: .infinity)
                        .background(.gray.opacity(0.15), in: .rect(cornerRadius: 12))
                }
            }
            .onAppear{
                showNote = true
            }
            .onDisappear{
                showNote = false
            }
        }
    }
}

#Preview {
    ContentView ()
}

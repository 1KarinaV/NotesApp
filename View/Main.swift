//
//  Main.swift
//  NotesApp
//
//  Created by Карина Владыкина on 27.01.2024.
//

import SwiftUI

struct Main: View {
    @Environment (\.modelContext) private var context
    
    @State private var selectedTag: String? = "All Notes"
    @State private var isDark: Bool = true
    var body: some View {
        NavigationView{
            List(selection: $selectedTag) {
                Text("All Notes")
                    .tag("All Notes")
                    .foregroundStyle(selectedTag == "All Notes" ? Color.primary: .gray)
                
                Text("Favourites")
                    .tag("Favourites")
                    .foregroundStyle(selectedTag == "Favourites" ? Color.primary: .gray)
            }
            
            //        } detail: {
            //           NotesView(category: selectedTag)
            //        }
            //        .navigationTitle(selectedTag ?? "Notes")
            
            //ToolBar items
            NotesView(category: selectedTag)
                .navigationTitle(selectedTag ?? "Notes")
                .toolbar {
                    ToolbarItem(placement: .primaryAction){
                        HStack(spacing: 10) {
                            //Adding new note
                            Button("", systemImage: "plus"){
                                let note = Note(content: "")
                                context.insert(note)
                            }
                            
                            
                            //Dark - light mode
                            Button("", systemImage: isDark ? "sun.min": "moon"){
                                isDark.toggle()
                            }
                            .contentTransition(.symbolEffect(.replace))
                        }
                    }
                }
        }
        .preferredColorScheme(isDark ? .dark: .light)
    }
}

#Preview {
    ContentView()
}

//
//  NoteDetail.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 11/7/24.
//

import SwiftUI

struct NoteDetail: View {
    
    @Binding var note : NoteModel
    @EnvironmentObject var avm : AuthenticationViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            TextField("Review Title", text: $note.title)
                .font(.system(size: 25))
            TextEditor(text: $note.notesdata)
                .font(.system(size: 20))
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    avm.saveData(note: note)
                    note.title = ""
                    note.notesdata = ""
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

//#Preview {
//    NoteDetail()
//}

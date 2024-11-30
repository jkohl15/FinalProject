//
//  NoteModel.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 11/7/24.
//

import Foundation
import FirebaseFirestore

struct NoteModel : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var notesdata: String
}

//
//  VisitorCenterViewModel.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 10/30/24.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class AuthenticationViewModel : ObservableObject {
    
    @Published var visitorCenterGeography: String = ""
    
    @Published var email = "jak0097@auburn.edu"
    @Published var password = "wareagle"
    @Published var currentUser : FirebaseAuth.User? = nil
    @Published var currentlyLoggedIn = false
    @Published private(set) var visitorCenterData = [VisitorCenterModel]()
    
    @Published var booleanFlag = false
    
    
    @Published var notes = [NoteModel]()
    let db = Firestore.firestore()
    
    private let url = "https://developer.nps.gov/api/v1/visitorcenters?limit=6&api_key=i2EgH3Qk7Yhu3cdNOV0DvagQ0VcSYZsLsiNfQCbx"
    
    init() {
                self.currentUser = Auth.auth().currentUser
        }
        
    func createUser() async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                print(authResult)
                self.currentUser = authResult?.user
                print("Successful")
            }
        } catch{
            print("Unsuccessful")
        }
    }

    func signIn() async {
            do {
                try await Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    print(authResult)
                    self.currentUser = authResult?.user
                    print("Successful")
                }
            } catch{
                print("Unsuccessful")
            }
        print(currentlyLoggedIn)
    }

        
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
        } catch{
        }
    }
    
    @MainActor
    func fetchData() async {
        if let url = URL(string: self.url) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let results = try JSONDecoder().decode(VisitorCenterResults.self, from: data)
                self.visitorCenterData = results.data
            } catch {
                print(error)
            }
        }
    }
    
    func fetchNotes() {
        self.notes.removeAll()
        db.collection("notes")
            .getDocuments() {
                (querySnapshot, err) in
                if let err = err {
                    print("Error fetching notes: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.notes.append(try document.data(as: NoteModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
    }
    
    
    
    
    
    func getFirestore(id: String) {
        let userRef = db.collection("Users").document(self.currentUser!.uid).collection("Favorites").document(id)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let property = document.get("flag")
                self.booleanFlag = self.getBoolFromAny(paramAny: property!)
                print("Document data: \(self.booleanFlag)")
            } else {
                print("Document does not exist")
                print(self.booleanFlag)
            }
        }
    }// added, on appear
    
    func getBoolFromAny(paramAny: Any)->Bool {
        let result = "\(paramAny)"
        return result == "1"
    }
    
    func favoriteButton(id: String) {
        let userRef = db.collection("Users").document(self.currentUser!.uid).collection("Favorites").document(id)
        booleanFlag = !booleanFlag
        userRef.setData([
            "flag": booleanFlag
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    
    
    
    
    
    func saveData(note: NoteModel) {
        
        if let id = note.id {
            //Edit note
            if !note.title.isEmpty || !note.notesdata.isEmpty {
                let docRef = db.collection("notes").document(id)
                docRef.updateData([
                    "title": note.title,
                    "notesdata": note.notesdata
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        } else {
            //Add note
            if !note.title.isEmpty || !note.notesdata.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("notes").addDocument(data: [
                    "title": note.title,
                    "notesdata": note.notesdata
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document successfully added with ID: \(ref!.documentID)")
                    }
                }
            }
        }
    }
    
}

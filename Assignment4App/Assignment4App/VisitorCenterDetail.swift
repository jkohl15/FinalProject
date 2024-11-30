//
//  VisitorCenterDetail.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 10/30/24.
//

import SwiftUI
import MapKit

struct VisitorCenterDetail: View {
    
    @EnvironmentObject var avm: AuthenticationViewModel
    @State var note = NoteModel(title: "", notesdata: "")
    var viscen : VisitorCenterModel
    
    var body: some View {
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Button(action: {
                        Task {
                            avm.favoriteButton(id: viscen.id)
                        }
                    }) {
                        Text("Add to Favorites")
                    }
                 
                    if avm.booleanFlag {
                        Image(systemName: "heart.fill")
                    } else {
                        //Text(String(avm.booleanFlag))
                        Image(systemName: "heart")
                    }
                }
                
                VStack (alignment: .leading, spacing: 10) {
                    Text("Visitor Center Name: ")
                    Text(viscen.name)
                }
                .font(.system(size: 20))
                .padding(.bottom)
                
                VStack (alignment: .leading, spacing: 10) {
                    Text("Visitor Center Description: ")
                    ScrollView{
                        Text(viscen.description)
                            .lineLimit(nil)
                    }
                }
                .font(.system(size: 20))
                .padding(.bottom)
                
                MapView(coordinate: CLLocationCoordinate2D(latitude: Double(viscen.latitude)!, longitude: Double(viscen.longitude)!))
                
            }
            .onAppear() {
                avm.getFirestore(id: viscen.id)
            }
            .background(Color.green).opacity(0.75).safeAreaPadding()
            
            
            NavigationLink {
                NavigationStack {
                    List {
                        ForEach($avm.notes) { $note in
                            NavigationLink {
                                NoteDetail(note: $note)
                            } label: {
                                Text(note.title)
                            }
                        }
                        
                        Section {
                            NavigationLink {
                                NoteDetail(note: $note)
                            } label: {
                                Text("New Review")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 15))
                            }
                        }
                    }
                    .onAppear{
                        avm.fetchNotes()
                    }
                    
                    //.listStyle(.grouped)
                    .navigationTitle("Visitor Center Reviews")
                    .refreshable {
                        avm.fetchNotes()
                    }
                }
            } label: {
                Text("Add and View Visitor Center Reviews")
            }
        
    }
        
}

//#Preview {
//    VisitorCenterDetail(viscen: <#T##VisitorCenterModel#>)
//}


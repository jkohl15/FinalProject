//
//  VisitorCenters.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 10/30/24.
//

import SwiftUI

struct VisitorCenters: View {
    
    //@ObservedObject var visitorcentervm = AuthenticationViewModel()
    @EnvironmentObject var avm: AuthenticationViewModel
    @State var note = NoteModel(title: "", notesdata: "")
    
    var body: some View {
            
            NavigationStack {
                List {
                    NavigationLink {
                        NavigationStack {
                            List {
                                ForEach(avm.visitorCenterData) { vc in
                                    NavigationLink {
                                        VisitorCenterDetail(viscen: vc)
                                    } label: {
                                        Text(vc.name)
                                    }
                                }
                            }
                            .navigationTitle("Visitor Centers")
                        }
                    } label: {
                        Text("List of Visitor Centers")
                    }
                    .task {
                        await avm.fetchData()
                    }
                    
                    NavigationLink {
                        GeographyView()
                    } label: {
                        Text("Visitor Centers by State")
                    }
                }
                
            }
        
            Button(action: {
                Task {
                    await avm.signOut()
                }
            }) {
                Text("Sign Out")
            }
        
    }
      
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VisitorCenters()
    }
}

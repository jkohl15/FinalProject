//
//  ContentView.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 11/5/24.
//

import SwiftUI
import FirebaseAuth

struct ContextView: View {
    
    @EnvironmentObject var avm: AuthenticationViewModel
    
    var body: some View {
        VStack {
            
            if avm.currentUser != nil {
                VisitorCenters()
            } else {
                LoginView()
            }
        }
    }
}

//
//  GeographyView.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 11/10/24.
//

import SwiftUI

struct GeographyView: View {
    
    @EnvironmentObject var avm: AuthenticationViewModel
    
    var body: some View {
        VStack {
            
            Text("Please enter one of the following state codes to see which of the listed visitor centers are located in that state: AL, NM, LA, MA, IL, AK.")
                    .padding()
            
            HStack{
                Text("Enter State:    ")
                TextField(
                    "State",
                    text: $avm.visitorCenterGeography)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            }.padding()
            
            if (avm.visitorCenterGeography == "AL") {
                Text("A.G. Gaston Motel")
            } else if (avm.visitorCenterGeography == "NM") {
                Text("Abo")
            } else if (avm.visitorCenterGeography == "LA") {
                Text("Acadain Cultural Center")
            } else if (avm.visitorCenterGeography == "MA") {
                Text("Adams National Historical Park Visitor Center")
            } else if (avm.visitorCenterGeography == "IL") {
                Text("Administration Clock Tower Building Visitor Center")
            } else if (avm.visitorCenterGeography == "AK") {
                Text("Administrative Offices")
            } else {
                Text("Empty String")
                    .hidden()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
                .accentColor(Color.black)
                .background(Color.green.opacity(0.75))
    }
        
    
}

#Preview {
    GeographyView()
}

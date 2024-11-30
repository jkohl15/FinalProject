//
//  ContactView.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 10/30/24.
//

import SwiftUI

struct ContactView: View {
    
    var icon : String
    var contact : String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(contact)
        }
        .padding()
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.blue, lineWidth: 2)
        }
    }
}

#Preview {
    ContactView(icon: "phone", contact: "123")
}


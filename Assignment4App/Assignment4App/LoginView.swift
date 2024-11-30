//
//  LoginView.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 11/5/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @EnvironmentObject var avm : AuthenticationViewModel
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Email:    ")
                TextField(
                    "Email",
                    text: $avm.email)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            }.padding()

            HStack{
                Text("Password:   ")
                SecureField(
                    "Password",
                    text: $avm.password)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            }.padding()

            Button(action: {
                Task {
                    await avm.createUser()
                }
            }) {
                Text("Create New User")
            }
            
            Button(action: {
                Task {
                    await avm.signIn()
                }
            }) {
                Text("Existing User - Sign In")
            }
            
            Text("Please ensure your password is at least six characters long and your email is valid with standard formatting.  Usernames already in existence cannot be re-used in the 'Create New User' process.  If you are not redirected to the navigation menu insde after entering username and password and pressing 'Create New User', creating the new user was not successful.")
                    .padding()
        }
    }
}

#Preview {
    LoginView()
}


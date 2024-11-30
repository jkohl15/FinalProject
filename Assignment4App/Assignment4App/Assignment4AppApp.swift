//
//  Assignment4AppApp.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 10/30/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct Assignment4AppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var avm = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContextView()
        }
        .environmentObject(avm)
    }
}

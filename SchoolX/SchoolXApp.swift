//
//  SchoolXApp.swift
//  SchoolX
//
//  Created by Akbar Khusanbaev on 13/10/23.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import GoogleSignInSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        guard let clientId = FirebaseApp.app()?.options.clientID else { return true }
        let configuration = GIDConfiguration(clientID: clientId)
        
        GIDSignIn.sharedInstance.configuration = configuration
        
        return true
    }
}

@main
struct SchoolXApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

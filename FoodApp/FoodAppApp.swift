//
//  FoodAppApp.swift
//  FoodApp
//
//  Created by Quang Bao on 22/08/2021.
//

import SwiftUI
import Firebase

@main
struct FoodAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//Intitalizing Firebase...
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
    FirebaseApp.configure()
    return true
  }
}

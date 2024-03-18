//
//  AI_Story_TellingApp.swift
//  AI Story Telling
//
//  Created by Log on 6/12/23.
//

import FirebaseCore
import SwiftUI
import GoogleMobileAds

@main
struct AI_Story_TellingApp: App {
    
    init () {
        FirebaseApp.configure()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

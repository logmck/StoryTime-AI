//
//  GoogleSignInViewController.swift
//  AI Storytime
//
//  Created by Log on 8/15/23.
//

import Foundation
import UIKit
import GoogleSignIn


class GoogleSignInViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Add a Google Sign-In button to the view
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.center = view.center
        view.addSubview(googleSignInButton)
    }
    
    // Implement GIDSignInDelegate methods
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // Handle sign-in error
            print("Google Sign-In Error: \(error.localizedDescription)")
            return
        }
        
        // Successful sign-in
        if let authentication = user.authentication as? GIDAuthentication {
            let idToken = authentication.idToken
            let accessToken = authentication.accessToken
            
            // Use the ID token and access token for further operations
        }
        
        // Dismiss the GoogleSignInViewController
        dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Handle user disconnect
    }
}

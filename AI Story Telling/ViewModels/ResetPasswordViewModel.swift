//
//  ResetPasswordViewModel.swift
//  AI Story Telling
//
//  Created by Log on 7/13/23.
//

import Foundation
import FirebaseAuth
import Firebase


class ResetPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var errorMessage = ""

    func resetPassword(email: String, completion: @escaping (String?) -> Void) {
        errorMessage = ""
        Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
            if let error = error {
                print("Error fetching sign-in methods: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if signInMethods?.isEmpty == true {
                completion("Email not found")
                return
            } else { self.errorMessage = "Email not found"}
            
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    print("Error sending password reset email: \(error.localizedDescription)")
                    completion("Error sending reset email")
                    return
                }
                self.errorMessage = "Email sent. Please check your inbox."
                completion(nil) // No error, reset email sent successfully
            }
        }
    }

    }
    

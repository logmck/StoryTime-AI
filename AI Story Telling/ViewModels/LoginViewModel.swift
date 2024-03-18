//
//  LoginViewModel.swift
//  AI Story Telling
//
//  Created by Log on 6/16/23.
//
import FirebaseAuth
import Foundation
import Firebase
import GoogleSignIn


class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error as NSError? {
                // Check the error code to determine the appropriate error message
                switch error.code {
                case AuthErrorCode.userNotFound.rawValue:
                    self?.errorMessage = "User not found. Please check your email"
                case AuthErrorCode.wrongPassword.rawValue:
                    self?.errorMessage = "Incorrect password. Please try again"
                default:
                    self?.errorMessage = "Error logging in. Please try again later"
                }
            }
        }
    }
    
    
    private func validate () -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return  false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        
        return true
    }
}

//
//  RegisterViewModel.swift
//  AI Story Telling
//
//  Created by Log on 6/16/23.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var passwordagain = ""
    @Published var name = ""
    @Published var errorMessage = ""
    var registrationSuccessCallback: (() -> Void)?


    init() {}
    
    func register() {
        guard validate() else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error as NSError? {
                // Check the error code to determine the appropriate error message
                if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    self?.errorMessage = "Email already in use"
                } else {
                    self?.errorMessage = "Error creating user. Please try again later"
                }
            } else if let userId = result?.user.uid {
                self?.insertUserRecord(id: userId)
                try? Auth.auth().signOut()
                self?.registrationSuccessCallback?()
            }
        }
    }



    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
        
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must be 6 characters or more"
            return false
        }
        if password != passwordagain {
            errorMessage = "Passwords do not match"
            return false
        }
        return true
    }

}

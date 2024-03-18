//
//  StoryDataManager.swift
//  AI Story Telling
//
//  Created by Log on 6/19/23.
//

import Foundation
import Firebase
import FirebaseFirestore

func saveStoryToFirestore(story: String) {
    guard let currentUser = Auth.auth().currentUser else {
        // User is not logged in
        return
    }
    
    let db = Firestore.firestore()
    let storiesCollection = db.collection("users").document(currentUser.uid).collection("stories")
    
    storiesCollection.addDocument(data: [
        "storyContent": story,
        "timestamp": Date()
    ]) { error in
        if let error = error {
            print("Error saving story: \(error.localizedDescription)")
        } else {
            print("Story saved successfully!")
        }
    }
}


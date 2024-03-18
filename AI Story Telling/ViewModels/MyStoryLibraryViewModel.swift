//
//  MyStoryLibraryViewModel.swift
//  AI Story Telling
//
//  Created by Log on 6/19/23.
//

import Foundation
import Firebase
import FirebaseFirestore


class MyStoryLibraryViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var trashStories: [Story] = []
    @Published var selectedStories: [Story] = []
    @Published var selectedTrashStories: [Story] = []
    var storyCount: Int = 0 // Hold the retrieved story count
 
    var isAnyStorySelected: Bool {
        return !selectedStories.isEmpty
    }
    
    var isAnyTrashStorySelected: Bool {
        return !selectedTrashStories.isEmpty
    }
    
    
    // Firestore database reference
    let db = Firestore.firestore()
    let maxContentLength = 100 // Maximum length of the content to show
    
    
    // Function to retrieve stories for the current user
    func retrieveStories() {
        guard let currentUser = Auth.auth().currentUser else {
            // User is not logged in
            return
        }
        db.collection("users").document(currentUser.uid).collection("stories").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting stories: \(error.localizedDescription)")
                return
            }
            var stories: [Story] = []
            for document in querySnapshot!.documents {
                let storyData = document.data()
                let story = Story(id: document.documentID, storyContent: storyData["storyContent"] as? String)
                stories.append(story)
            }
            self.stories = stories // Update the stories property
        }
    }

    
    func toggleSelectStory(_ story: Story) {
        if selectedStories.contains(where: { $0.id == story.id }) {
            selectedStories.removeAll { $0.id == story.id }
        } else {
            selectedStories.append(story)
        }
    }

    //deletes stories in Database and UI view
    func deleteSelectedStories() {
        guard let currentUser = Auth.auth().currentUser else {
            // User is not logged in
            return
        }
        
        let storyCollectionRef = db.collection("users").document(currentUser.uid).collection("stories")
        let trashCollectionRef = db.collection("users").document(currentUser.uid).collection("storytrash")
        
        for story in selectedStories {
            storyCollectionRef.document(story.id).getDocument { (document, error) in
                if let error = error {
                    print("Error getting story document: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document, document.exists else {
                    print("Story document does not exist")
                    return
                }
                
                guard let storyData = document.data() else {
                    print("Invalid story data")
                    return
                }
                
                trashCollectionRef.document(story.id).setData(storyData) { (error) in
                    if let error = error {
                        print("Error moving story to trash collection: \(error.localizedDescription)")
                        return
                    }
                    
                    storyCollectionRef.document(story.id).delete { (error) in
                        if let error = error {
                            print("Error deleting story: \(error.localizedDescription)")
                        } else {
                            // Remove deleted stories from the main stories array
                            self.stories.removeAll { deletedStory in
                                self.selectedStories.contains { selectedStory in
                                    return selectedStory.id == deletedStory.id
                                }
                            }
                            // Clear the selected stories array
                            self.selectedStories.removeAll()
                        }
                    }
                }
            }
        }
    }


    func removeStories(at offsets: IndexSet) {
            stories.remove(atOffsets: offsets)
        }
    //allows user to update their stories
        
        
        func updateStory(_ story: Story, withContent newContent: String) {
               guard let currentUser = Auth.auth().currentUser else {
                   return
               }

               // Update the content of the story in the database
            db.collection("users").document(currentUser.uid).collection("stories").document(story.id).updateData([
                   "storyContent": newContent
               ]) { error in
                   if let error = error {
                       print("Error updating story content: \(error.localizedDescription)")
                   } else {
                       // Update the corresponding Story object in the 'stories' array
                       if let index = self.stories.firstIndex(where: { $0.id == story.id }) {
                           self.stories[index].storyContent = newContent
                       }
                   }
               }
           }
    
    func clearTrashSelection() {
        selectedTrashStories.removeAll()
    }
    
    func toggleSelectTrashStory(_ story: Story) {
            if selectedTrashStories.contains(where: { $0.id == story.id }) {
                selectedTrashStories.removeAll { $0.id == story.id }
            } else {
                selectedTrashStories.append(story)
            }
        }
    
    //Restore selected story back to main library view
    func restoreSelectedStoriesFromTrash() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let trashCollectionRef = db.collection("users").document(currentUser.uid).collection("storytrash")
        let storyCollectionRef = db.collection("users").document(currentUser.uid).collection("stories")
        
        for story in selectedTrashStories {
            trashCollectionRef.document(story.id).getDocument { (document, error) in
                if let error = error {
                    print("Error getting story document from trash: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document, document.exists else {
                    print("Story document does not exist in trash")
                    return
                }
                
                guard let storyData = document.data() else {
                    print("Invalid story data in trash")
                    return
                }
                
                storyCollectionRef.document(story.id).setData(storyData) { (error) in
                    if let error = error {
                        print("Error restoring story to main collection: \(error.localizedDescription)")
                        return
                    }
                    
                    trashCollectionRef.document(story.id).delete { (error) in
                        if let error = error {
                            print("Error deleting story from trash: \(error.localizedDescription)")
                        } else {
                            DispatchQueue.main.async {
                                self.trashStories.removeAll { $0.id == story.id }
                                self.selectedStories.removeAll { $0.id == story.id }
                            }
                        }
                    }
                }
            }
        }
    }



    
    //List stories in the storytrash collection from Firebase
    func retrieveTrashStories(completion: @escaping ([Story]) -> Void) {
            guard let currentUser = Auth.auth().currentUser else {
                // User is not logged in
                completion([])
                return
            }
            
            let trashCollectionRef = db.collection("users").document(currentUser.uid).collection("storytrash")
            
            trashCollectionRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting trash stories: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                var stories: [Story] = []
                for document in querySnapshot!.documents {
                    let storyData = document.data()
                    let story = Story(id: document.documentID, storyContent: storyData["storyContent"] as? String)
                    stories.append(story)
                }
                completion(stories)
            }
        }
    
    // Truncate the content text to a specific length
    func truncateContent(_ content: String?) -> String {
        let truncatedContent = content?.prefix(maxContentLength) ?? ""
        if truncatedContent.count > maxContentLength {
            let adjustedTruncatedContent = String(truncatedContent.prefix(maxContentLength)).replacingOccurrences(of: #"^\n+"#, with: "", options: .regularExpression)
            return adjustedTruncatedContent + "..." // Add ellipsis to indicate truncation
        } else {
            let adjustedContent = String(truncatedContent).replacingOccurrences(of: #"^\n+"#, with: "", options: .regularExpression)
            return adjustedContent
        }
    }

   }


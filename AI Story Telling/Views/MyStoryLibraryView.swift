//
//  MyStoryLibraryView.swift
//  AI Story Telling
//
//  Created by Log on 6/15/23.
//

import SwiftUI
import Firebase

//View to read selected story
struct StoryContentView: View {
    let story: Story
    @ObservedObject var viewModel: MyStoryLibraryViewModel
    @State private var isEditing: Bool = false
    @State private var editedContent: String

    init(story: Story, viewModel: MyStoryLibraryViewModel) {
        self.story = story
        self.viewModel = viewModel
        _editedContent = State(initialValue: story.storyContent ?? "")
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background1")
                    .ignoresSafeArea()
                ScrollView {
                    if isEditing {
                        TextEditor(text: $editedContent)
                            .font(Font.custom("Noteworthy", size: 20))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding()
                            .frame(minHeight: 1000)
                    } else {
                        VStack(alignment: .leading) {
                            Text(editedContent)
                                .font(Font.custom("Noteworthy", size: 20))
                                .fontWeight(.bold)
                                .padding()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        shareStory()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color("Red1"))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: isEditing ? "checkmark" : "square.and.pencil")
                        .foregroundColor(Color("Red1"))
                        .onTapGesture {
                            if isEditing {
                                                            viewModel.updateStory(story, withContent: editedContent)
                                                        }
                                                        isEditing.toggle()
                                                    }

                }
            }
        }
    }

    func shareStory() {
        if let content = story.storyContent {
            let avc = UIActivityViewController(activityItems: [content], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(avc, animated: true, completion: nil)
        }
    }
}




//View to edit selected story
//struct EditStoryView: View {
//    @State private var isEditing: Bool = false
//    @State private var editedContent: String = ""
//    let story: Story
//    let viewModel: MyStoryLibraryViewModel
//
//    var body: some View {
//        ZStack {
//            Color("Background1")
//                .ignoresSafeArea()
//            ScrollView {
//                VStack {
//                    if isEditing {
//                        TextEditor(text: $editedContent)
//                            .font(Font.custom("Noteworthy", size: 20))
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .padding()
//                            .frame(minHeight: 200)
//                    } else {
//                        Text(story.storyContent ?? "No Content")
//                            .font(Font.custom("Noteworthy", size: 20))
//                            .padding()
//                    }
//                }
//            }
//            .onAppear(perform: {
//                editedContent = story.storyContent ?? ""
//                viewModel.retrieveStories()
//            })
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                if !isEditing {
//                    Button(action: {
//                        isEditing.toggle()
//                        editedContent = story.storyContent ?? ""
//                    }) {
//                        Image(systemName: "square.and.pencil")
//                            .foregroundColor(Color("Red1"))
//                    }
//                } else {
//                    Button(action: {
//                        isEditing.toggle()
//                        viewModel.updateStory(story, withContent: editedContent)
//                    }) {
//                        Image(systemName: "checkmark")
//                            .foregroundColor(Color("Red1"))
//                    }
//                }
//            }
//        }
//    }
//}



// View of all deleted stories from current user
struct TrashView: View {
    @ObservedObject var viewModel: MyStoryLibraryViewModel
    @Binding var showTrash: Bool
    
    var body: some View {
        ZStack {
            Color("Background1")
                .ignoresSafeArea()
            VStack {
                Text("Restore Deleted Stories")
                    .font(Font.custom("Noteworthy", size: 20))
                    .fontWeight(.bold)
                    .padding()
                
                ScrollView {
                    VStack {
                        if !viewModel.trashStories.isEmpty {
                            ForEach(viewModel.trashStories, id: \.id) { story in
                                HStack {
                                    Text(viewModel.truncateContent(story.storyContent))
                                        .font(Font.custom("Noteworthy", size: 20))
                                        .foregroundColor(Color("Red1"))
                                        .fontWeight(.bold)
                                        .padding()

                                    Spacer()

                                    Button(action: {
                                        viewModel.toggleSelectTrashStory(story)
                                    }) {
                                        if viewModel.selectedTrashStories.contains { $0.id == story.id } {
                                            Image(systemName: "checkmark.circle.fill")
                                        } else {
                                            Image(systemName: "circle")
                                        }
                                    }
                                    .foregroundColor(Color("Red1"))
                                    .padding(.trailing, 10)
                                }
                            }
                        } else {
                            Text("No stories to restore")
                                .font(Font.custom("Noteworthy", size: 20))
                                .padding()
                        }
                    }
                }
                
                HStack{
                    Button(action: {
                        viewModel.restoreSelectedStoriesFromTrash()
                    }) {
                        Text("Restore Selected")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(Font.custom("Noteworthy", size: 18))
                            .padding()
                            .background(viewModel.isAnyTrashStorySelected ? Color("Red1") : Color.gray)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        showTrash.toggle()
                        viewModel.retrieveStories()
                        viewModel.clearTrashSelection()
                    }) {
                        Text("Close")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Red1"))
                            .font(Font.custom("Noteworthy", size: 18))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
            .onAppear {
                viewModel.retrieveTrashStories { stories in
                    DispatchQueue.main.async {
                        viewModel.trashStories = stories
                    }
                }
            }
        }
    }
}

// Main Story library view
struct MyStoryLibraryView: View {
    @ObservedObject var viewModel = MyStoryLibraryViewModel()
    @State private var showTrash: Bool = false
    @State private var isLoading: Bool = true
    
    let randomSpineImages = "Spine2"


    var body: some View {
        ZStack {
            Color("Background1")
                .ignoresSafeArea()

        if isLoading { // Display loading screen
            ProgressView("Loading Stories...")
                .font(Font.custom("Noteworthy", size: 20))
                .foregroundColor(Color("Purple1"))
                .onAppear {
                    viewModel.retrieveStories()
                    // Simulate a 2-second delay and then set isLoading to false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading = false
                    }
                }
        } else {
            ScrollView {
                VStack {
                    Text("My Story Library")
                        .font(Font.custom("Noteworthy", size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Purple1"))
                        .underline()
                    if viewModel.stories.isEmpty {
                        Text("No stories just yet!")
                            .font(Font.custom("Noteworthy", size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Purple1"))
                            .padding()
                    } else {
                        ForEach(viewModel.stories) { story in
                            NavigationLink(
                                destination: StoryContentView(story: story, viewModel: MyStoryLibraryViewModel())
                            ) {
                                VStack(alignment: .center) {
                                    Image(randomSpineImages) // Display the random image
                                        .resizable()
                                        .cornerRadius(50)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 350, height: 100)
                                        .overlay(
                                            HStack {
                                                Text(viewModel.truncateContent(story.storyContent))
                                                    .font(Font.custom("Noteworthy", size: 20))
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                                    .padding()
                                                    .padding(.leading, 80.0)
                                                Spacer()
                                                Button(action: {
                                                    if let index = viewModel.selectedStories.firstIndex(where: { $0.id == story.id }) {
                                                        viewModel.selectedStories.remove(at: index)
                                                    } else {
                                                        viewModel.selectedStories.append(story)
                                                    }
                                                }) {
                                                    if viewModel.selectedStories.contains(where: { $0.id == story.id }) {
                                                        Image(systemName: "checkmark.circle.fill")
                                                    } else {
                                                        Image(systemName: "circle")
                                                    }
                                                }
                                                .foregroundColor(Color("Red1"))
                                                .padding(.trailing, 10)
                                                .padding(.trailing)
                                            }
                                        )
//                                        .padding()
                                }
                            }
                        }
                    }
                    
                    
                }
                }
                .onAppear {
                    viewModel.retrieveStories()
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showTrash.toggle()
                }) {
                    Image(systemName: "clock.arrow.circlepath")
                        .foregroundColor(Color("Red1"))
                }

                .sheet(isPresented: $showTrash) {
                    TrashView(viewModel: viewModel, showTrash: $showTrash)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    viewModel.deleteSelectedStories()
                }) {
                    if !viewModel.isAnyStorySelected {
                        Image(systemName: "trash")
                        .foregroundColor(.gray)
                    } else {
                        Image(systemName: "trash")
                            .foregroundColor(Color("Red1"))
                    }
                }
                .disabled(!viewModel.isAnyStorySelected)
            }
        }
    }
}

    



struct MyStoryLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        MyStoryLibraryView()
    }
}

    





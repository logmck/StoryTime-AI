//
//  ContentView.swift
//  AI Story Telling
//
//  Created by Log on 6/12/23.
//

import SwiftUI

extension Color {
    static let customBlack = Color(red: 0, green: 0, blue: 0, opacity: 1.0)
}

struct StoryInput: View {
    
    @StateObject var viewModel = StoryInputViewModel()
    @State private var showGeneratedStory = false
    @State private var showInfo: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
            ZStack {
                Color("Background1")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .center) {
                        
                        HStack{
                            Text("Let's Read About...")
                                .font(Font.custom("Noteworthy", size: 35))
                                .fontWeight(.bold)
                                .foregroundColor(.gray)

                            //Disclaimer button
                            Button(action: {
                                showInfo.toggle()
                            }) {
                                Image(systemName: "info.circle")
                                    .font(Font.system(size: 24))
                                    .foregroundColor(Color("Purple1"))
                            }
                            .padding(.trailing, 16)
                            .sheet(isPresented: $showInfo) {
                                DisclaimerView()
                            }
                        }
                        Spacer()
                        VStack(alignment: .center) {
                            
                            if colorScheme == .light {
                                Image("StoryLight")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 150)
                                    .padding()
                            } else {
                                Image("StoryDark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 150)
                                    .padding()
                            }
                            
                            TextField("Character Name...", text: $viewModel.name)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("Turq")))
                                .foregroundColor(Color.primary)
                                .colorScheme(.light)
                            
                            
                            TextField("Character Type (Hero, Princess)...", text: $viewModel.type)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("lightr")))
                                .foregroundColor(Color.primary)
                                .colorScheme(.light)
                            
                            TextField("Location (Castle, Forest)...", text: $viewModel.location)
                                .foregroundColor(Color.primary)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("purple")))
                                .foregroundColor(Color.primary)
                                .colorScheme(.light)
                            
                            TextField("Gender...", text: $viewModel.gender)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("Tan")))
                                .foregroundColor(Color.primary)
                                .colorScheme(.light)
                            
                            
                            TextField("Character Interests...", text: $viewModel.interests)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("Turq")))
                                .foregroundColor(Color.primary)
                                .colorScheme(.light)
                            
                            TextField("Lesson Taught", text: $viewModel.lesson)
                                .foregroundColor(.customBlack)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("lightr")))
                                .foregroundColor(Color.primary)
                                .colorScheme(.light)
                            
                            Spacer()
                            
                            
                            NavigationLink(destination: GeneratedStoryView(viewModel: viewModel)) {
                                Text("Create Story")
                                    .font(Font.custom("Noteworthy", size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.customBlack)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("Tan"))
                                            .frame(width: 360)
                                        
                                    )
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                viewModel.generateStory()
                            })
                        }
                        
                        .padding()
                        AdViewRepresentable()
                                .frame(height: 50)
                    }
                    .modifier(KeyboardAdaptive())
                }
            }
        }
    }

        
        struct StoryInput_Previews: PreviewProvider {
            static var previews: some View {
                StoryInput()
            }
        }
        
        
    


//
//  HomeScreen1.swift
//  AI Story Telling
//
//  Created by Log on 6/14/23.
//
import SwiftUI
import GoogleMobileAds


struct HomeScreen: View {
    @State private var isActive: Bool = false
    @State private var showInfo: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("Background1")
                    .ignoresSafeArea()
                
                
                VStack() {
                    Spacer()
                        Text("It's story time!")
                            .font(Font.custom("Noteworthy", size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Purple1"))
                    
                    if colorScheme == .light {
                                    Image("BookLight")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300, height: 200)
                                } else {
                                    Image("BookDark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 300, height: 200)
                                }
                            
                    Spacer()
                    //Create Story Button
                    ZStack {
                    NavigationLink(destination: StoryInput()) {
                        Image("Spine1")
                            .resizable()
                            .frame(width: 360, height: 75)
                            .cornerRadius(60)
                    }
                        Text("Create New Story")
                            .font(Font.custom("Noteworthy", size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Purple1"))
                            .padding()
                            .frame(width: 350, height: 75)
                            .cornerRadius(10)
                    }
                    
//                    .background(
//                        RoundedRectangle(cornerRadius: 25)
//                            .fill(Color("Gold1")))
                    
                    
                    
                    
                    //My Story Library Button
                    ZStack{
                        NavigationLink(destination: MyStoryLibraryView()) {
                            Image("Spine2")
                                .resizable()
                                .frame(width: 360, height: 75)
                                .cornerRadius(60)
                        }
                        Text("My Story Library")
                            .font(Font.custom("Noteworthy", size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Red1"))
                            .padding()
                            .frame(width: 330, height: 75)
                            .cornerRadius(10)
                    }
                    
//                    .background(
//
//                        RoundedRectangle(cornerRadius: 25)
//                            .fill(Color("Gold1")))
                    
            
                    
                    
                    
                    //Public Library button
                    ZStack {
                        NavigationLink(destination: StoryTimeLibraryView()) {
                            Image("Spine3")
                                .resizable()
                                .frame(width: 360, height: 75)
                                .cornerRadius(60)
                        }
                        HStack {
                            Spacer()
                            Text("Storytime Library")
                                .font(Font.custom("Noteworthy", size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(Color("Color 1"))
                                .padding()
                                .padding(.trailing)
                                .frame(width: /*@START_MENU_TOKEN@*/340.0/*@END_MENU_TOKEN@*/, height: 75)
                                .cornerRadius(10)
                        }
                    }
//                                        .background(
//
//                        RoundedRectangle(cornerRadius: 25)
//                            .fill(Color("Gold1")))
                    
                    
                    
                    //Account setting button
                    ZStack {
                        NavigationLink(destination: AccountSettingsView()) {
                            Image("Spine4")
                                .resizable()
                                .frame(width: 360, height: 75)
                                .cornerRadius(60)
                        }
                        
                            Text("Account Settings")
                                .font(Font.custom("Noteworthy", size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .padding()
                                .frame(width: /*@START_MENU_TOKEN@*/340.0/*@END_MENU_TOKEN@*/, height: 75)
                                .cornerRadius(10)
                        }
                    
//                    .background(
//
//                        RoundedRectangle(cornerRadius: 25)
//                            .fill(Color("Gold1")))
                    
                    Spacer()
                    AdViewRepresentable()
                            .frame(height: 50)
                }
                
            }
        }
        }
    }

struct spine1Button: View {
    let imageName: String
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 500, height: 50) // Set the size of the image
                Text(buttonText)
                    .font(.caption) // Adjust font size
                    .foregroundColor(.black) // Adjust text color
            }
        }
    }
}


    
    struct HomeScreen_Previews: PreviewProvider {
        static var previews: some View {
            HomeScreen()
        }
    }


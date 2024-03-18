//
//  AccountSettingsView.swift
//  AI Story Telling
//
//  Created by Log on 6/15/23.
//

import SwiftUI

struct AccountSettingsView: View {
    @StateObject var viewModel = AccountSettingsViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background1")
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                    Text("Account Settings")
                        .font(Font.custom("Noteworthy", size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .underline()
                    Spacer()
                    if let user = viewModel.user {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("Cyan1"))
                            .frame(width: 125, height: 125)
                        
                        VStack {
                            
                            HStack {
                                Text("Name: ")
                                    .font(Font.custom("Noteworthy", size: 20))
                                    .fontWeight(.bold)
                                Text(user.name)
                                    .font(Font.custom("Noteworthy", size: 15))
                                    .fontWeight(.bold)
                            }
                            .padding()
                            HStack {
                                Text("Email: ")
                                    .font(Font.custom("Noteworthy", size: 20))
                                    .fontWeight(.bold)
                                Text(user.email)
                                    .font(Font.custom("Noteworthy", size: 15))
                                    .fontWeight(.bold)
                            }
                            .padding()
                            HStack {
                                Text("Member Since: ")
                                    .font(Font.custom("Noteworthy", size: 20))
                                    .fontWeight(.bold)
                                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                                    .font(Font.custom("Noteworthy", size: 15))
                                    .fontWeight(.bold)
                            }
                            .padding()
                            Color("Background1")
                        }
                        
                        
                        Button {
                            viewModel.logOut()
                        } label: {
                            ZStack{
                                Color("Background1")
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("Red1"))
                                    .frame(width: 300, height: 40)
                                Text("Log Out")
                                    .font(Font.custom("Noteworthy", size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                
                            }
                            
                        }
                        Link("Contact us", destination: URL(string: "mailto:storytimeai.help@gmail.com")!)
                                .foregroundColor(Color.blue)
                    Spacer()
                        
                    } else {
                        ProgressView("Loading Profile...")
                            .font(Font.custom("Noteworthy", size: 20))
                            .foregroundColor(Color("Purple1"))
                    }
                   Spacer()
                    AdViewRepresentable()
                            .frame(height: 50)
                }
                
            }
            .onAppear {
                viewModel.fetchUser()
            }
        }
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}

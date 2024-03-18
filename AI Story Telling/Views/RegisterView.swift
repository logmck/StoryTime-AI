//
//  RegisterView.swift
//  AI Story Telling
//
//  Created by Log on 6/15/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Background1")
                    .ignoresSafeArea()
                
                VStack{
                    
                    Text("Storytime")
                        .font(Font.custom("Noteworthy", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(Color("lightr"))
                    
                    if colorScheme == .light {
                                    Image("books")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 400, height: 350)
                                } else {
                                    Image("BooksDark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 400, height: 350)
                                }
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color("Red1"))
                    }
                    
                    
                    VStack {
                        TextField("Full Name", text: $viewModel.name)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .autocorrectionDisabled()
                        
                        TextField("Email Address", text: $viewModel.email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
                        SecureField("Retype Password", text: $viewModel.passwordagain)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
                        
                        
                        Button {
                            viewModel.registrationSuccessCallback = {
                                  // Dismiss the current view when registration is successful
                                  self.presentationMode.wrappedValue.dismiss()
                              }
                            viewModel.register()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("Turq"))
                                    .frame(width: 300, height: 40)
                                Text("Create Account")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                
                            }
                            
                        }
                        Spacer()
                            .padding()
                    }
                }
                .modifier(KeyboardAdaptive())
            }
        }
    }
    
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView()
        }
    }
}

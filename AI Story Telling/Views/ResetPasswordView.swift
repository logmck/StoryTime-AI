//
//  ResetPasswordView.swift
//  AI Story Telling
//
//  Created by Log on 7/13/23.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject var viewModel = ResetPasswordViewModel()
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        ZStack{
            Color("Background1")
                .ignoresSafeArea()
            
            VStack{
                
                Text("Storytime")
                    .font(Font.custom("Noteworthy", size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Red1"))
                
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
                    TextField("Email Address", text: $viewModel.email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()

                    
                    
                    
                    Button {
                        viewModel.resetPassword(email: viewModel.email) { error in
                            if let error = error {
                                print("Reset password error: \(error)")
                            } else {
                                print("Reset password email sent successfully")
                            }
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("Red1"))
                                .frame(width: 300, height: 40)
                            Text("Reset Password")
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            
                        }
                        
                    }
                    
                }
                
            }
            .modifier(KeyboardAdaptive())
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}

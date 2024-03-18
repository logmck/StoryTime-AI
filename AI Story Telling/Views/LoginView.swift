//
//  LoginView.swift
//  AI Story Telling
//
//  Created by Log on 6/14/23.
//

import SwiftUI
import Combine
import GoogleSignInSwift

struct KeyboardResponsiveModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .animation(.easeInOut(duration: 0.25))
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
                    keyboardHeight = keyboardFrame.height
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    keyboardHeight = 0
                }
            }
    }
}


extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardResponsiveModifier())
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0 }

        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}


struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background1")
                    .ignoresSafeArea()
                
                    VStack {
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
                            
                            Button {
                                viewModel.login()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("Turq"))
                                        .frame(width: 300, height: 40)
                                    Text("Log In")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                }
                            }
                            
                            NavigationLink(destination: RegisterView()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("Turq"))
                                        .frame(width: 300, height: 40)
                                    Text("Create Account")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                }
                            }
                            
                            NavigationLink(destination: ResetPasswordView()) {
                                Text("Forgot your password?")
                                    .foregroundColor(Color("lightr"))
                            }
                            Spacer()
                        }
                    }
                .modifier(KeyboardAdaptive())
                .navigationBarHidden(true)
            }
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
    
}

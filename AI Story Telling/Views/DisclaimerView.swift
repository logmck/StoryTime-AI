//
//  DisclaimerView.swift
//  AI Story Telling
//
//  Created by Log on 7/14/23.
//

import SwiftUI

struct DisclaimerView: View {
    var body: some View {
        ZStack {
            Color("Background1")
                .ignoresSafeArea()
            
            VStack(alignment: .center){
                Text("Before you begin")
                    .fontWeight(.bold)
                    .foregroundColor(Color("lightr"))
                    .underline()
                    .padding(.vertical)
                    .font(Font.custom("Noteworthy",size:40))
                
                Spacer()
                Text("Please note that all stories are created by an AI language model. While AI is not able to create explicit or vulgar content it can have errors and/or content that you may not like.")
                    .fontWeight(.bold)
                    .foregroundColor(Color("lightr"))
                    .padding(.all)
                    .font(Font.custom("Noteworthy",size:25))
                
                Text("Feel free to delete, edit the stories in the My Story Library, or go back and create a new story.")
                    .foregroundColor(Color("lightr"))
                    .font(Font.custom("Noteworthy",size:25))
                    .fontWeight(.bold)
                    .padding(.all)
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}

struct DisclaimerView_Previews: PreviewProvider {
    static var previews: some View {
        DisclaimerView()
    }
}

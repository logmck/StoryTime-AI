//
//  StroyTimeLibraryView.swift
//  AI Story Telling
//
//  Created by Log on 6/15/23.
//

import SwiftUI

struct StoryTimeLibraryView: View {
    var body: some View {
        ZStack {
            Color("Background1")
                .ignoresSafeArea()
            VStack{
                Text("Storytime Library")
                    .font(Font.custom("Noteworthy", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .underline()
                
                Spacer()
                
                Text("Coming Soon!")
                    .font(Font.custom("Noteworthy", size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(Color("lightr"))
                    .padding()
                
                Spacer()
            }
        }
    }
}

struct StoryTimeLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryTimeLibraryView()
    }
}

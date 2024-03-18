//
//  ProfilePicPickerView.swift
//  AI Story Telling
//
//  Created by Log on 7/27/23.
//

import SwiftUI
import UIKit

struct ProfilePicPickerView: View {
    let predefinedImageNames = ["image1", "image2", "image3"]
    @State private var selectedImage: String?
    
    var body: some View {
        ZStack{
            Color("Background1")
                .ignoresSafeArea()
            VStack {
                ForEach(predefinedImageNames, id: \.self) { imageName in
                    Button(action: {
                        selectedImage = imageName
                    }) {
                        Image(imageName)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedImage == imageName ? Color.blue : Color.clear, lineWidth: 2)
                            )
                    }
                }
                
                if let selectedImage = selectedImage {
                    Text("Selected image: \(selectedImage)")
                } else {
                    Text("Please select an image")
                }
            }
        }
    }
}


struct ProfilePicPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicPickerView()
    }
}

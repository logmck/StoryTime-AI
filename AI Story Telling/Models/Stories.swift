//
//  Stories.swift
//  AI Story Telling
//
//  Created by Log on 6/19/23.
//

import Foundation

struct Story: Identifiable {
    var id: String
    var title: String? = nil
    var storyContent: String?
    
    init(id: String, storyContent: String?) {
        self.id = id
        self.storyContent = storyContent
    }
}



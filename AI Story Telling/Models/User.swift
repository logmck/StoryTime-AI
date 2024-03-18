//
//  User.swift
//  AI Story Telling
//
//  Created by Log on 6/16/23.
//

import Foundation


struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}

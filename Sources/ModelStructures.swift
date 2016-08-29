//
//  ModelStructures.swift
//  TwitterClone
//
//  Created by David Ungar on 8/28/16.
//
//

import Foundation

struct Post {
    var id: UUID?
    let user: String
    let body: String
    let timestamp: Date
}

struct Users {
    var id: UUID?
    let name: String
}

struct Relationship {
    var id: UUID?
    let followee: String
    let follower: String
}


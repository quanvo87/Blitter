//
//  ModelStructures.swift
//  TwitterClone
//
//  Created by David Ungar on 8/28/16.
//
//

import Foundation

typealias TwitterCloneModel = HasFieldNames // & Others someday

// ensure use of field names is consistent
// All possible versions of this app will need to know the field names
// Can we use reflection instead?
protocol HasFieldNames {
    associatedtype FieldNames: Hashable
}

struct Post: TwitterCloneModel {
    enum FieldNames: String {
        case id, user, body, timestamp
    }
    var id: UUID?
    let user: String
    let body: String
    let timestamp: Date
}

struct Users: TwitterCloneModel {
    enum FieldNames: String {
        case id, name
    }
    var id: UUID?
    let name: String
}

struct Relationship: TwitterCloneModel {
    enum FieldNames: String {
        case id, followee, follower
    }
    var id: UUID?
    let followee: String
    let follower: String
}

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


struct Tweets: TwitterCloneModel {
    enum FieldNames: String {
        case id, author, subscriber, tweet, timestamp
    }
    
    var id: UUID?
    let author: String
    let subscriber: String
    let tweet: String
    let timestamp: Date
}

struct Subscription: TwitterCloneModel {
    enum FieldNames: String {
        case id, author, subscriber
    }
    var id: UUID?
    let author: String
    let subscriber: String
}

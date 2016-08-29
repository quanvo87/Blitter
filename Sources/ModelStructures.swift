//
//  ModelStructures.swift
//  TwitterClone
//
//  Created by David Ungar on 8/28/16.
//
//

import Foundation

// ensure use of field names is consistent
protocol HasFieldNames {
    associatedtype FieldNames: Hashable
}

// TODO: move this proto and conformance into a separate file
// TODO: abstract conformance into Model
protocol NamingForCassandra: Equatable {
    var nameForCassandra: String {get}
    static var idCase: Self {get}
    var rawValue: String {get}
}
private let cassandraDeleteRequiresIDFieldToBeNamedID = "id"
extension NamingForCassandra {
    var nameForCassandra: String {
        return self == Self.idCase
            ? cassandraDeleteRequiresIDFieldToBeNamedID
            : rawValue
    }
}


struct Post: HasFieldNames {
    enum FieldNames: String, NamingForCassandra {
        case id, user, body, timestamp
        static let idCase = id
    }
    var id: UUID?
    let user: String
    let body: String
    let timestamp: Date
}

struct Users: HasFieldNames {
    enum FieldNames: String, NamingForCassandra {
        case id, name
        static let idCase = id
    }
    var id: UUID?
    let name: String
}

struct Relationship: HasFieldNames {
    enum FieldNames: String, NamingForCassandra {
        case id, followee, follower
        static let idCase = id
    }
    var id: UUID?
    let followee: String
    let follower: String
}

protocol NamingForClientJSONConversion {
    var rawValue: String {get}
    var nameForClientJSON: String {get}
}
extension NamingForClientJSONConversion {
    var nameForClientJSON: String {
        return rawValue
    }
}

// TODO: abstract this
extension Post.FieldNames: NamingForClientJSONConversion {}
extension Users.FieldNames: NamingForClientJSONConversion {}
extension Relationship.FieldNames: NamingForClientJSONConversion {}

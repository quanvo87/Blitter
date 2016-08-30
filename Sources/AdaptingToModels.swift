//
//  AdaptingToModels.swift
//  TwitterClone
//
//  Created by David Ungar on 8/29/16.
//
//

import Foundation
import Kassandra


extension Tweets: Model {
    typealias Field = FieldNames
    
    static let tableName = "Tweets"
    
    static var primaryKey: Field {
        return Field.id
    }
    
    static var fieldTypes: [Field: DataType] {
        return [
            .id         : .uuid,
            .author     : .text,
            .subscriber : .text,
            .tweet      : .text,
            .timestamp  : .timestamp
        ]
    }
    
    var key: UUID? {
        get {
            return self.id
        }
        set {
            self.id = newValue
        }
    }
    
    init(row: Row) {
        self.id         = row[FieldNames.id        .nameForCassandra] as? UUID
        self.author     = row[FieldNames.author    .nameForCassandra] as! String
        self.subscriber = row[FieldNames.subscriber.nameForCassandra] as! String
        self.tweet      = row[FieldNames.tweet     .nameForCassandra] as! String
        self.timestamp  = row[FieldNames.timestamp .nameForCassandra] as! Date
    }
}



extension Subscription: Model {
    typealias Field = FieldNames
    
    static let tableName = "subscription"
    
    static var primaryKey: Field {
        return Field.id
    }
    
    static var fieldTypes: [Field: DataType] {
        return [.id  : .uuid, .author: .text, .subscriber: .text]
    }
    
    var key: UUID? {
        get {
            return self.id
        }
        set {
            self.id = newValue
        }
    }
    
    init(row: Row) {
        self.id          = row[FieldNames.id         .nameForCassandra] as? UUID
        self.author      = row[FieldNames.author     .nameForCassandra] as! String
        self.subscriber  = row[FieldNames.subscriber .nameForCassandra] as! String
    }
}

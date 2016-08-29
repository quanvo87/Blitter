//
//  Relationship.swift
//  TwitterClone
//
//  Created by David Ungar on 8/28/16.
//
//

import Foundation
import Kassandra

extension Relationship: Model {
    typealias Field = FieldNames
    
    static let tableName = "Relationship"
    
    static var primaryKey: Field {
        return Field.id
    }
    
    static var fieldTypes: [Field: DataType] {
        return [.id  : .uuid, .followee: .text, .follower: .text]
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
        self.id         = row[FieldNames.id.nameForCassandra      ] as? UUID
        self.follower   = row[FieldNames.follower.nameForCassandra] as! String
        self.followee   = row[FieldNames.followee.nameForCassandra] as! String
    }
}

//
//  Post.swift
//  TwitterClone
//
//  Created by David Ungar on 8/28/16.
//
//

import Foundation
import Kassandra



extension Post: Model {
    typealias Field = FieldNames
    
    static let tableName = "Posts"
    
    static var primaryKey: Field {
        return Field.id
    }
    
    static var fieldTypes: [Field: DataType] {
        return [
            .id         : .uuid,
            .user       : .text,
            .body       : .text,
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
        self.id         = row[FieldNames.id.nameForCassandra       ] as? UUID
        self.user       = row[FieldNames.user.nameForCassandra     ] as! String
        self.body       = row[FieldNames.body.nameForCassandra     ] as! String
        self.timestamp  = row[FieldNames.timestamp.nameForCassandra] as! Date
    }
}


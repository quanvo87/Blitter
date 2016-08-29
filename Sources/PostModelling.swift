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
    enum Field: String {
        case id = "id"
        case user = "user"
        case body  = "message"
        case timestamp = "timestamp"
    }
    
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
        self.id         = row["id"] as? UUID
        self.user       = row["user"] as! String
        self.body       = row["body"] as! String
        self.timestamp  = row["timestamp"] as! Date
    }
}


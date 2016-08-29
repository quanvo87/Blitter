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
    enum Field: String {
        case id         = "id"
        case followee   = "followee"
        case follower   = "follower"
    }
    
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
        self.id         = row["id"] as? UUID
        self.follower   = row["follower"] as! String
        self.followee   = row["followee"] as! String
    }
}

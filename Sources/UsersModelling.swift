//
//  Users.swift
//  TwitterClone
//
//  Created by David Ungar on 8/28/16.
//
//

import Foundation
import Kassandra



extension Users: Model {
    typealias Field = FieldNames
    
    static let tableName = "Users"
    
    static var primaryKey: Field {
        return Field.id
    }
    
    static var fieldTypes: [Field: DataType] {
        return [.id  : .uuid, .name: .text]
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
        self.id         = row[FieldNames.id.nameForCassandra]   as? UUID
        self.name       = row[FieldNames.name.nameForCassandra] as! String
    }
}

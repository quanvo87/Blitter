//
//  NamingFieldsForCassandra.swift
//  TwitterClone
//
//  Created by David Ungar on 8/29/16.
//
//

import Foundation


protocol NamingFieldsForCassandra: Equatable {
    var nameForCassandra: String {get}
    static var idCase: Self {get}
    var rawValue: String {get}
}
private let cassandraDeleteRequiresIDFieldToBeNamedID = "id"
extension NamingFieldsForCassandra {
    var nameForCassandra: String {
        return self == Self.idCase
            ? cassandraDeleteRequiresIDFieldToBeNamedID
            : rawValue
    }
}

extension Tweets        .FieldNames: NamingFieldsForCassandra { static let idCase = id }
extension Subscription  .FieldNames: NamingFieldsForCassandra { static let idCase = id }

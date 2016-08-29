//
//  NamingJSONFields.swift
//  TwitterClone
//
//  Created by David Ungar on 8/29/16.
//
//

import Foundation

protocol NamingForClientJSONConversion {
    var rawValue: String {get}
    var nameForClientJSON: String {get}
}
extension NamingForClientJSONConversion {
    var nameForClientJSON: String {
        return rawValue
    }
}

// TODO: abstract conformance so that these three are just one line about TwitterCloneModel
extension Post        .FieldNames: NamingForClientJSONConversion {}
extension Users       .FieldNames: NamingForClientJSONConversion {}
extension Relationship.FieldNames: NamingForClientJSONConversion {}

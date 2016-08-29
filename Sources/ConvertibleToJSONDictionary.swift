//
//  ConvertibleToJSONDictionary.swift
//  TwitterClone
//
//  Created by David Ungar on 8/28/16.
//
//

import Foundation

typealias JSONDictionary = [String : Any]

protocol ConvertibleToJSONDictionary {
    func toDictionary() -> JSONDictionary
}


extension Array where Element : ConvertibleToJSONDictionary {
        func toDictionary() -> [JSONDictionary] {
        return self.map { $0.toDictionary() }
    }
}



extension Post: ConvertibleToJSONDictionary {
    func toDictionary() -> JSONDictionary {
        var result = JSONDictionary()
        // var result = [String:Any]()
        
        result[FieldNames.id       .nameForClientJSON] = self.id
        result[FieldNames.user     .nameForClientJSON] = self.user
        result[FieldNames.body     .nameForClientJSON] = self.body
        result[FieldNames.timestamp.nameForClientJSON] = self.timestamp
        
        return result
    }
}


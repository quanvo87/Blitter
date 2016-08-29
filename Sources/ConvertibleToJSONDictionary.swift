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
        
        result["id"]        = self.id
        result["user"]      = self.user
        result["body"]      = self.body
        result["timestamp"] = self.timestamp
        
        return result
    }
}

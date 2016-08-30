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



extension Tweets: ConvertibleToJSONDictionary {
    func toDictionary() -> JSONDictionary {
        var result = JSONDictionary()
        // var result = [String:Any]()
        
        result[FieldNames.id          .nameForClientJSON] = "\(id!)"
        result[FieldNames.author      .nameForClientJSON] =    author
        result[FieldNames.subscriber  .nameForClientJSON] =    subscriber
        result[FieldNames.tweet       .nameForClientJSON] =    tweet
        result[FieldNames.timestamp   .nameForClientJSON] = "\(timestamp)"
        
        return result
    }
}

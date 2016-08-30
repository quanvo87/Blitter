//
//  ConvertibleFromJSON.swift
//  TwitterClone
//
//  Created by David Ungar on 8/29/16.
//
//

import Foundation
import SwiftyJSON

protocol ConvertibleFromJSONDictionary {
    init(json: JSON)
}


extension Tweets: ConvertibleFromJSONDictionary {
    init(json: JSON) {
        fatalError("unimplemented")
    }
}
extension Subscription: ConvertibleFromJSONDictionary {
    init(json: JSON) {
        fatalError("unimplemented")
    }
}

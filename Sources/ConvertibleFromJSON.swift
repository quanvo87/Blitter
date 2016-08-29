//
//  ConvertibleFromJSOND.swift
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


extension Post: ConvertibleFromJSONDictionary {
    init(json: JSON) {
        let user    = json[FieldNames.user      .nameForClientJSON].stringValue
        let message = json[FieldNames.body      .nameForClientJSON].stringValue
        let time    = json[FieldNames.timestamp .nameForClientJSON].stringValue
            |> DateFormatter().date(from:)
            |> {$0!}
        
        self.init(id: UUID(), user: user, body: message, timestamp: time)
    }
}

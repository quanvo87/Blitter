//
//  KituraDriver.swift
//  TwitterClone
//
//  Created by David Ungar on 8/29/16.
//
//

import Foundation
import Kitura
import Kassandra


struct OriginalTwitterCloneKituraDriver {
    
    public let router = Router()
    public let kassandra = Kassandra()
    
    let id = "follow/:id"
    let theClone: TwitterCloneProtocol = OriginalTwitterClone()
    
    public init() {
        
        router.get("/",  handler: theClone.getAll)
        router.post("/", handler: theClone.tweet)
        router.post(id,  handler: theClone.follow)
        
        
        Kitura.addHTTPServer(onPort: 8090, with: router)
    }
    
    public func run () {
        Kitura.run()
    }
    
}

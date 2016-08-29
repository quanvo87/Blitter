//
//  OriginalTwitterClone.swift
//  TwitterClone
//
//  Created by David Ungar on 8/28/16.
//
//

import Foundation
import Kitura
import Kassandra
import SwiftyJSON


public struct OriginalTwitterClone: TwitterCloneProtocol {
    public func tweet(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        
        guard let body = request.body else {
            response.status(.badRequest)
            return
        }
        
        guard case let .json(json) = body else {
            response.status(.badRequest)
            return
        }
        
        let user    = json["user"].stringValue
        let message = json["body"].stringValue
        let time    = DateFormatter().date(from: json["timestamp"].stringValue)!
        
        let post = Post(id: UUID(), user: user, body: message, timestamp: time)
        
        post.save() { _ in
            
            do {
                try response.status(.OK).end()
                
            } catch {
                print(error)
            }
        }
        
    }
    
    public func getAll(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        
        //let userID: String = request.userProfile?.name
        
        guard let userID = request.parameters["userID"] else {
            response.status(.badRequest)
            return
        }
        
        Relationship.fetch(predicate: "user" == userID, limit: 50) { result, error in
            
            let friends = result!.map { $0.follower }
            
            Post.fetch(predicate: "user" > friends, limit: 50) { tweets, error in
                
                if let twts = tweets {
                    do {
                        try response.status(.OK).send(json: JSON(twts.toDictionary())).end()
                        
                    } catch {
                        print(error)
                    }
                }
            }
            
        }
        
    }
    
    public func follow(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        
        guard let body = request.body else {
            response.status(.badRequest)
            return
        }
        
        guard case let .json(json) = body else {
            response.status(.badRequest)
            return
        }
        
        let user1 = json["followee"].stringValue
        let user2 = json["follower"].stringValue
        
        Relationship.insert([.id: UUID(), .follower: user1, .followee: user2]).execute { _ in
            
            do {
                try response.status(.OK).end()
                
            } catch {
                print(error)
            }
            
            
        }
    }
}

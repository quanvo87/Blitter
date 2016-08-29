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
        
        Post(json: json).save() { _ in
            
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
        // FIXME: Is this right?
        Relationship.fetch(predicate: Post.FieldNames.user.nameForCassandra == userID, limit: 50) { result, error in
            
            let friends = result!.map { $0.follower }
            
            Post.fetch(predicate: Post.FieldNames.user.nameForCassandra > friends, limit: 50) { tweets, error in
                
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
        
        let followee = json[Relationship.FieldNames.followee.nameForClientJSON].stringValue
        let follower = json[Relationship.FieldNames.follower.nameForClientJSON].stringValue
        
        let followeeForInsertion = follower
        let followerForInsertion = followee
        Relationship.insert([.id: UUID(),
                             .follower: followerForInsertion,
                             .followee: followeeForInsertion])
            .execute { _ in
                
                do {
                    try response.status(.OK).end()
                    
                } catch {
                    print(error)
            }
            
            
        }
    }
}

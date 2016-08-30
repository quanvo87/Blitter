/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation
import Kitura
import Kassandra
import SwiftyJSON


public struct OriginalTwitterClone: TwitterCloneProtocol {
    public let kassandra = Kassandra()

    public func tweet(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        
        //let profile = request.userProfile
        let userID = "Chia"
        
        guard let body = request.body else {
            response.status(.badRequest)
            return
        }
        
        guard case let .json(json) = body else {
            response.status(.badRequest)
            return
        }
        
        let tweet = json["tweet"].stringValue
        
        try kassandra.connect(with: "twissandra") { result in
            
            self.kassandra.execute("select subscriber from subscription where author='\(userID)'"){ result in
                let rows = result.asRows!
                
                let subscribers: [String] = rows.map {
                    return $0["subscriber"] as! String
                }
                
                let newTweets: [Tweets] = subscribers.map {
                    let tweet = Tweets(id: UUID(),
                                       author: userID,
                                       subscriber: $0,
                                       tweet: tweet,
                                       timestamp: Date())
                    return tweet
                }
                
                newTweets.forEach { $0.save() { _ in } }
                
                do {
                    try response.status(.OK).end()
                    
                } catch {
                    print(error)
                }
                
            }
            
        }
    }
    
    public func getMyFeed(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        
        //let userID: String = request.userProfile?.name
        
        /*guard let userID = request.parameters["userID"] else {
         response.status(.badRequest)
         return
         }*/
        let user = "Aaron"
        
        try kassandra.connect(with: "twissandra") { result in
            Tweets.fetch(predicate: "subscriber" == user, limit: 50) { tweets, error in
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
    
    public func getUserTweets(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        
        guard let myUsername = request.parameters["user"] else {
            response.status(.badRequest)
            return
        }
        
        try kassandra.connect(with: "twissandra") { result in
            Tweets.fetch(predicate: "author" == myUsername, limit: 50) { tweets, error in
                
                if let twts = tweets {
                    do {
                        let ret = twts.toDictionary()
                        let retjson = JSON(ret)
                        try response.status(.OK).send(json: retjson).end()
                        
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    
    public func followAuthor(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        
        let author = "Raymond"
        
        guard let myUsername = request.parameters["user"] else {
            response.status(.badRequest)
            return
        }
        try kassandra.connect(with: "twissandra") { _ in
            Subscription.insert([.id: UUID(), .author: author, .subscriber: myUsername]).execute { result in
                do {
                    try response.status(.OK).end()
                    
                } catch {
                    print(error)
                }
            }
        }
    }
}



//create table tweetgroup(id uuid, followee text, follower text, tweet text, timestamp timestamp, primary key(id));



// create keyspace twissandra with replication = {'class':'SimpleStrategy', 'replication_factor' : 1};
// create table tweets(id uuid, author text, tweet text, subscriber text, timestamp timestamp, primary key(id));
// create index on tweets(author);
// create index on tweets(subscriber);
// create table subscription(id uuid primary key, author text, subscriber text) ;
// CREATE INDEX ON subscription(author);

//insert into tweets(id, author, tweet, subscriber, timestamp) values (uuid(), 'Joseph', 'Done with School', 'Aaron', toTimestamp(now()));


//create table tweets(id uuid primary key, user text, body text, timestamp timestamp) ;
//create table user(id uuid primary key, name text) ;

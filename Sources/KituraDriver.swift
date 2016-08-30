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


public struct OriginalTwitterCloneKituraDriver {
    
    public let router = Router()
    
    let id = "follow/:id"
    let theClone: TwitterCloneProtocol = OriginalTwitterClone()
    
    public init() {
        /**
         Allows JSON to be consumed
         */
        router.all("/*", middleware: BodyParser())
        
        /**
         Gets all the tweets that I have subscribed to.
         
         curl localhost:8090
         */
        router.get("/", handler: theClone.getMyFeed)
        
        /**
         Gets all the tweets that a particular user has written
         
         curl localhost:8090/rfdickerson
         */
        router.get("/:user", handler: theClone.getUserTweets)
        
        /**
         Create a new tweet
         
         curl -X POST -d "{\"tweet\": \"I just tweeted!\"}" localhost:8090
         */
        router.post("/", handler: theClone.tweet)
        
        /**
         Follow a new author
         
         curl -X PUT localhost:8090/rfdickerson
         */
        router.put("/:user", handler: theClone.followAuthor)
        
        Kitura.addHTTPServer(onPort: 8080, with: router)        
    }
    
    public func run () {
        Kitura.run()
    }
    
}

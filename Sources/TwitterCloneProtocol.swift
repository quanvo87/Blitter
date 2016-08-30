//
//  TwitterCloneProtocol.swift
//  TwitterClone
//
//  Created by David Ungar on 8/28/16.
//
//

import Foundation

import Kitura

public protocol TwitterCloneProtocol {
    func tweet (       request: RouterRequest, response: RouterResponse, next: () -> Void) throws
    func getMyFeed(    request: RouterRequest, response: RouterResponse, next: () -> Void) throws
    func getUserTweets(request: RouterRequest, response: RouterResponse, next: () -> Void) throws
    func followAuthor( request: RouterRequest, response: RouterResponse, next: () -> Void) throws
}

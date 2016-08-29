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
    func tweet (request: RouterRequest, response: RouterResponse, next: () -> Void)
    func getAll(request: RouterRequest, response: RouterResponse, next: () -> Void)
    func follow(request: RouterRequest, response: RouterResponse, next: () -> Void)
}

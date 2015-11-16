//
//  Post.swift
//  coreDev-Showcase
//
//  Created by Samuel Atwell on 11/16/15.
//  Copyright © 2015 CoreDev. All rights reserved.
//

import Foundation

class Post {
    private var _postDescription: String!
    private var _postImageUrl: String?
    private var _postSocks: Int!
    private var _username: String!
    private var _postKey: String!
    
    var postDescription: String {
        return _postDescription
    }
    
    var imageUrl: String? {
        return _postImageUrl
    }
    
    var socks: Int {
        return _postSocks
    }
    
    var username: String {
        return _username
    }
    
    init(description: String, imageUrl: String?, username: String) {
        self._postDescription = description
        self._postImageUrl = imageUrl
        self._username = username
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let socks = dictionary ["socks"] as? Int {
            self._postSocks = socks
        }
        
        if let imageUrl = dictionary["imageUrl"] as? String {
            self._postImageUrl = imageUrl
        }
        
        if let desc = dictionary["description"] as? String {
            self._postDescription = desc
        }
    }
}
//
//  DataServices.swift
//  coreDev-Showcase
//
//  Created by Samuel Atwell on 11/15/15.
//  Copyright © 2015 CoreDev. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "https://coreshowcase.firebaseio.com")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
}
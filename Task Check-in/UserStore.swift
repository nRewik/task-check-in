//
//  UserStore.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation

class UserStore{
    
    static let defaultStore = UserStore()
    private init(){ }
    
    /// stored session token
    var currentUserToken = ""
}
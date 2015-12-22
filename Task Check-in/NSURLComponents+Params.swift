//
//  NSURLComponents+Params.swift
//  Hermes
//
//  Created by DW78 on 9/1/15.
//  Copyright (c) 2015 Dezainwerkz. All rights reserved.
//

import Foundation

extension NSURLComponents{
    
    var params: [String:String?]{
        
        var _params: [String:String?] = [:]
        if let queryItems = queryItems{
            for item in queryItems{
                _params[item.name] = item.value
            }
        }
        return _params
    }
    
}
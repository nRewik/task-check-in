//
//  Route.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation
import Alamofire

/// Route has all the requirement to convert to a request.
protocol Route{
    var method: Alamofire.Method { get }
    var path: String { get }
    var parameters: [String:AnyObject] { get }
}
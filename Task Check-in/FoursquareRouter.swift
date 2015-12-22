//
//  FoursquareRouter.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Router
enum FoursquareRouter: URLRequestConvertible{
    
    case foursquareRoute( route: FoursquareRoute, token: String)
    
    var URLRequest: NSMutableURLRequest{
        
        let URL = NSURL(string: Foursquare.baseAPIurl)!
        
        switch(self){
        case let .foursquareRoute(route: route, token: token):
            
            let mutableURLRequest = NSMutableURLRequest( URL: URL.URLByAppendingPathComponent(route.path) )
            mutableURLRequest.HTTPMethod = route.method.rawValue
            
            var params = route.parameters
            params["oauth_token"] = token
            
            params["v"] = Foursquare.apiVersion // version
            params["m"] = Foursquare.apiMode // mode
            
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
        }
        
    }
    
}

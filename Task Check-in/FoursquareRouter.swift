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
    
    case foursquareRoute( route: FoursquareRoute, token: String?)
    
    var URLRequest: NSMutableURLRequest{
        
        let URL = NSURL(string: Foursquare.baseAPIurl)!
        
        switch(self){
        case let .foursquareRoute(route: route, token: token):
            
            let mutableURLRequest = NSMutableURLRequest( URL: URL.URLByAppendingPathComponent(route.path) )
            mutableURLRequest.HTTPMethod = route.method.rawValue
            
            var params = route.parameters
            
            if let token = token{
                /* 
                    Access token use for user authentication.
                    Some endpoints will give more personalized answer based on user actor.
                */
                params["oauth_token"] = token
            }else{
                /* userless access */
                params["client_id"] = Foursquare.clientID
                params["client_secret"] = Foursquare.clientSecret
            }
            
            params["v"] = Foursquare.apiVersion // version
            params["m"] = Foursquare.apiMode // mode
            
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
        }
        
    }
    
}

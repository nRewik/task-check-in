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
enum Router: URLRequestConvertible{
    
    case FoursquareRoute( router: FoursquareRouter, token: String)
    
    var URLRequest: NSMutableURLRequest{
        
        let URL = NSURL(string: Foursquare.baseAPIurl)!
        
        switch(self){
        case let .FoursquareRoute(router: router, token: token):
            
            let mutableURLRequest = NSMutableURLRequest( URL: URL.URLByAppendingPathComponent(router.path) )
            mutableURLRequest.HTTPMethod = router.method.rawValue
            
            var params = router.parameters
            params["oauth_token"] = token
            
            params["v"] = Foursquare.apiVersion // version
            params["m"] = Foursquare.apiMode // mode
            
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
        }
        
    }
    
}

// MARK: - FoursquareRouter
protocol FoursquareRouter{
    
    var method: Alamofire.Method { get }
    var path: String { get }
    var parameters: [String:AnyObject] { get }
}

public enum VenueRouter: FoursquareRouter{
    
    case Search(latitude: String, longitude: String, radius: Int)
    
    public var method: Alamofire.Method {
        switch self {
        case .Search:
            return .GET
        }
    }
    
    public var path: String {
        switch self {
        case .Search:
            return "/venues/search"
        }
    }
    
    public var parameters: [String:AnyObject] {
        
        var params: [String:AnyObject] = [:]
        
        switch self{
        case let .Search(latitude: latitude, longitude: longitude, radius: radius):
            params["ll"] = "\(latitude),\(longitude)"
            params["radius"] = "\(radius)"
            params["intent"] = "browse"
        }
        
        return params
    }
    
    
}








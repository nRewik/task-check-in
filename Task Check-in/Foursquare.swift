//
//  Foursquare.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import FutureKit

class Foursquare{
    
    static let serverURL = "https://foursquare.com"
    static let clientID = "KYAMZDRGQV2VF00S22T1BPOGQJF00GUDEIP2V1RMZ0Q5NJTK" /* don't reveal this to anybody */
    static let clientSecret = "ULCUMTHUUF3J3V5RKVQ0WPMCJMCX43M1YCEEKUBBRDWEBOWL" /* don't reveal this to anybody */
    static let redirectURI = "https://nrewik.github.io/task-check-in/redirect" /* don't reveal this to anybody */
    
    static let baseAPIurl = "https://api.foursquare.com/v2"
    static let apiVersion = "20140806"
    static let apiMode = "foursquare"

    
    func getToken(code: String) -> Future<String> {
        
        // url
        let url = Foursquare.serverURL + "/oauth2/access_token"
        
        // params
        var params: [String:AnyObject] = [:]
        
        params["client_id"] = Foursquare.clientID
        params["client_secret"] = Foursquare.clientSecret
        params["redirect_uri"] = Foursquare.redirectURI
        
        params["grant_type"] = "authorization_code"
        params["code"] = code
        
        let request = Alamofire.request( .POST, url, parameters: params)
        
        return request.responseJSONPromise().onSuccess{ json -> Future<String> in
            
            let promise = Promise<String>()
            if let accessToken = json["access_token"].string{
                promise.completeWithSuccess(accessToken)
            }else{
                promise.completeWithFail("cannot find access token.")
            }
            return promise.future
        }
    }
    
    /// fire the request from any FoursquareRoute
    /// - returns: JSON response from foursquare api.
    
    func responseFromRoute<T: FoursquareRoute>(route: T, accessToken token: String) -> Future<JSON>{
        let router = FoursquareRouter.foursquareRoute(route: route, token: token)
        let request = Alamofire.request(router)
        return request.responseJSONPromise()
    }
    
    
    
    
}
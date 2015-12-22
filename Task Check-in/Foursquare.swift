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
    static let clientID = "😁" /* don't reveal this to anybody */
    static let clientSecret = "😁" /* don't reveal this to anybody */
    static let redirectURI = "😁" /* don't reveal this to anybody */
    
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
    
    func responseFromRoute<T: FoursquareRouter>(router: T, accessToken token: String) -> Future<JSON>{
        let mainRouter = Router.FoursquareRoute(router: router, token: token)
        let request = Alamofire.request(mainRouter)
        return request.responseJSONPromise()
    }
    
    
    
    
}
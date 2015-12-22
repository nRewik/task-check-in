//
//  Alamofire.Request+Future.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import FutureKit

public extension Request {
    
    
    public static func JSONPromiseResponseSerializer() -> ResponseSerializer<JSON, NSError> {
        return ResponseSerializer { request, response, data, error in
            
            guard error == nil else {
                return Result.Failure(error!)
            }
            
            guard let notEmptyData = data else{
                let nilJSON = JSON( NSNull() )
                return Result.Success(nilJSON)
            }
            
            let json = JSON(data: notEmptyData)
            return Result.Success(json)
        }
    }
    
    public func responseJSONPromise() -> Future<JSON> {
        
        let promise = Promise<JSON>()
        
        // call response with custom json response serializer
        response(responseSerializer: Request.JSONPromiseResponseSerializer() ){ response in
            
            switch response.result{
            case let .Failure(error):
                promise.completeWithFail(error)
            case let .Success(value):
                promise.completeWithSuccess(value)
            }
            
        }
        
        return promise.future
    }
    
    
}











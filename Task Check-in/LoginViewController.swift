//
//  LoginViewController.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class LoginViewController: UIViewController {

    let foursquare = Foursquare()
    let webView = WKWebView()
    
    let customRedirectURI = "https://nrewik.github.io/task-check-in/redirect"
    
    @IBOutlet weak var webViewReferenceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webViewReferenceView.addSubview(webView)
        webView.navigationDelegate = self
        
        navigateToFoursquareAuthenticationPage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = webViewReferenceView.bounds
    }
    
    
    func navigateToFoursquareAuthenticationPage(){
        
        let oauthURL = Foursquare.serverURL + "/oauth2/authenticate"
        
        var params: [String:AnyObject] = [:]
        params["client_id"] = Foursquare.clientID
        params["response_type"] = "code"
        params["redirect_uri"] = customRedirectURI
        
        let request = Alamofire.request(.GET, oauthURL, parameters: params)
        
        webView.loadRequest(request.request!)
    }
    
    
}

extension LoginViewController: WKNavigationDelegate{
    
    func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
        
        /* 
            If redirect url matches the `redirect_uri` params that we sent before,
            then find `code` params within redirect url.
            Otherwise just ignore.
        */
        
        if let
            url = navigationResponse.response.URL,
            components = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
        {
            
            let params = components.params
            if let _code = params["code"], code = _code{
                
                print("code \(code)")
                
                /* request for access token, after found code */
                foursquare
                    .getToken(code)
                    .onSuccess{ token in
                        
                        print("token: \(token)")
                        
                        /* set current session token */
                        UserStore.defaultStore.currentUserToken = token
                        
                        self.performSegueWithIdentifier("showLocationViewController", sender: self)
                    }
                    .onFail{ error in
                        print("get token error: \(error)")
                    }
                
                decisionHandler(.Cancel)
            }
        }
        
        decisionHandler(.Allow)
    }
    
}













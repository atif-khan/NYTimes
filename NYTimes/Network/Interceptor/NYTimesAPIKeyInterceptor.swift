//
//  NYTimesAPIKeyInterceptor.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation

class NYTimesAPIKeyInterceptor: RequestAdapter {
    
    let APIKEY = "i2TrqVzNudiM45V0p9BF6MD0uQvyPQLF"
    
    func adapt(_ urlRequest: inout URLRequest, in session: URLSessionProtocol) {
                
        if let urlStr = urlRequest.url?.absoluteString {
            
            let queryItem = URLQueryItem(name: "api-key", value: APIKEY)
            var queryComp = URLComponents(string: urlStr)
            queryComp?.queryItems?.append(queryItem)
            
            urlRequest.url = queryComp?.url
        }
        
    }
    
}

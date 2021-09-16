//
//  MockURLSessionDataTask.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private (set) var resumeWasCalled = false
        
    func resume() {
        resumeWasCalled = true
    }
    
}

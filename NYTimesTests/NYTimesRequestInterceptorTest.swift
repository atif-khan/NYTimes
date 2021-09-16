//
//  NYTimesRequestInterceptorTest.swift
//  NYTimesTests
//
//  Created by Atif Khan on 16/09/2021.
//

import XCTest
@testable import NYTimes

class NYTimesRequestInterceptorTest: XCTestCase {

    var interceptor: NYTimesAPIKeyInterceptor!
    
    override func setUpWithError() throws {
        interceptor = NYTimesAPIKeyInterceptor()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIKeyAdded() throws {
        
        var request = URLRequest(baseUrl: BASE_URL, path: "svc/mostpopular/v2/viewed/1.json", method: .get, params: [:])
        interceptor.adapt(&request, in: MockURLSession())
        
        let queryParams = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
        
        XCTAssertNotNil(queryParams!.queryItems!.contains(URLQueryItem(name: "api-key", value: "i2TrqVzNudiM45V0p9BF6MD0uQvyPQLF")))
    }
    
    func testCorrectAPIKey() throws {
        
        var request = URLRequest(baseUrl: BASE_URL, path: "svc/mostpopular/v2/viewed/1.json", method: .get, params: [:])
        interceptor.adapt(&request, in: MockURLSession())
        
        let queryParams = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
        
        XCTAssertTrue(queryParams!.queryItems!.contains(URLQueryItem(name: "api-key", value: "i2TrqVzNudiM45V0p9BF6MD0uQvyPQLF")))
    }
    
    func testWrongAPIKey() throws {
        
        var request = URLRequest(baseUrl: BASE_URL, path: "svc/mostpopular/v2/viewed/1.json", method: .get, params: [:])
        interceptor.adapt(&request, in: MockURLSession())
        
        let queryParams = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
        
        XCTAssertFalse(queryParams!.queryItems!.contains(URLQueryItem(name: "api-key", value: "wrongKey")))
    }

}

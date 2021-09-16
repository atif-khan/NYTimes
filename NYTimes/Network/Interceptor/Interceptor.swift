//
//  Interceptor.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation

protocol RequestAdapter {
    func adapt(_ urlRequest: inout URLRequest, in session: URLSessionProtocol)
}

protocol ResponseParser {
    func parse(_ response: URLResponse, for request: URLRequest, in session: URLSessionProtocol)
}

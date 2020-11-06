//
//  MockURLProtocol.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/13/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var stubedError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override func startLoading() {
        if let error = MockURLProtocol.stubedError {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() { }
}

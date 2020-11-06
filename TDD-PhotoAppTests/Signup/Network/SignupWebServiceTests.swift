//
//  SignupWebServiceTests.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/13/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import XCTest
@testable import TDD_PhotoApp

class SignupWebServiceTests: XCTestCase {

    var sut: SignupWebService!
    var signupRequestModel: SignupRequestModel!

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        signupRequestModel = SignupRequestModel(firstName: "Jyoti", lastName: "sahoo", email: "jsahoo@apple.com", password: "12345678")
    }

    override func tearDownWithError() throws {
        sut = nil
        signupRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.stubedError = nil
    }

    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        // Arrange
        let jsonData = "{\"status\": \"ok\"}"
        MockURLProtocol.stubResponseData = jsonData.data(using: .utf8)
        let expectation = self.expectation(description: "Successful response Expectation")
        // Act
        self.sut.signUp(with: signupRequestModel) { signupResponseModel, signupError in
            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testSignupWebService_WhenReceiveDiffJsonResponse_ErrorTookPlace() {
        // Arrange
        let jsonData = "{\"path\":\"/user\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonData.data(using: .utf8)
        let expectation = self.expectation(description: "Different Json Response")
        // Act
        self.sut.signUp(with: signupRequestModel) { (model, error) in
            // Assert
            XCTAssertEqual(error, SignupError.invalidJsonResponse, "Signup method did not return expected error")
            XCTAssertNil(model, "Response Model for a request containing unknown json resposne, should have been nil")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testSignupWebService_WhenEmptyURLGiven_ErrorTookPlace() {
        // Arrange
        let sut = SignupWebService(urlString: "")
        let expectation = self.expectation(description: "Invalid URL")
        // ACT
        sut.signUp(with: signupRequestModel) { (responseModel, error) in
            // Assert
            XCTAssertEqual(error, SignupError.invalidURLString, "Signup Method did not return expected Error for invalid URL")
            XCTAssertNil(responseModel, "Unexpected Resposne Obejct for Invalid URL")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testSignupWebService_WhenRequestFailed_ErrorTookPlace() {
        // Arrange
        let errorDescription = "A Localized Error Description"
        let error = SignupError.requestFailed(description: errorDescription)
        MockURLProtocol.stubedError = error
        let expectation = self.expectation(description: "Signup Method Request Failed")
        // ACT
        sut.signUp(with: signupRequestModel) { (model, error) in
            // Assert
            XCTAssertEqual(error, SignupError.requestFailed(description: errorDescription), "The Signup Method didnot retrun an expected error for Failed request")
            XCTAssertNil(model, "Unexpected Resposne Obejct when request Failed")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}

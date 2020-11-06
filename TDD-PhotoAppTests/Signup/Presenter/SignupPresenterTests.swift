//
//  SignupPresenterTests.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/14/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import XCTest
@testable import TDD_PhotoApp

class SignupPresenterTests: XCTestCase {
    var signupModel: SignupModel!
    var mockSignupModelValidater: MockSignupModelValidater!
    var mockSignupWebservice: MockSignupWebService!
    var sut: SigupPresenter!
    var mocksignupviewDelegate: MockSignupViewDelegate!

    override func setUpWithError() throws {
        signupModel = SignupModel(firstName: "Jyoti", lastName: "Sahoo", email: "jsahoo@apple.com", password: "12345678", repeatPassword: "12345678")
        mockSignupModelValidater = MockSignupModelValidater()
        mockSignupWebservice = MockSignupWebService()
        mocksignupviewDelegate = MockSignupViewDelegate()
        sut = SigupPresenter(validator: mockSignupModelValidater, signupWebService: mockSignupWebservice, delegate: mocksignupviewDelegate)
    }

    override func tearDownWithError() throws {
        signupModel = nil
        mockSignupModelValidater = nil
        mockSignupWebservice = nil
        sut = nil
    }
    func testSignupPresenter_WhenInformationProvided_WillValidateEachField() {
        // Arrange
        // Act
        sut.processUserSignup(formModel: signupModel)
        // Assert
        XCTAssertTrue(mockSignupModelValidater.isFirstNameValid, "First Name was not Validated")
        XCTAssertTrue(mockSignupModelValidater.isLastNameValid, "Last Name was not Validated")
        XCTAssertTrue(mockSignupModelValidater.isPasswordValid, "Password was not Validated")
        XCTAssertTrue(mockSignupModelValidater.isEmailValid, "Email was not Validated")
        XCTAssertTrue(mockSignupModelValidater.isPasswordMatch, "Password match was not Validated")
    }

    func testSignupPresenter_whenValidfromModelIsGiven_shouldCallSignup() {
        // Arrange
        // Act
        sut.processUserSignup(formModel: signupModel)
        // Assert
        XCTAssertTrue(mockSignupWebservice.isSignupMethodCalled, "signUp() method didn't get called")
    }
    func testSignupPresenter_WhenSignupsuccessfull_ShouldcallSuccessOnViewDelegate() {
        // Arrange
        let expectation = self.expectation(description: "Expect the success handler to be called")
        mocksignupviewDelegate.expectation = expectation
        // Act
        sut.processUserSignup(formModel: signupModel)
        // Assert
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mocksignupviewDelegate.numberOfCallToSignupSuccess == 1, "signup() method called more than Once")
    }
    func testSignupPresenter_WhenSignupFailed_ShouldCallFailedOnViewDeleagte() {
        // Arrange
        let expectation = self.expectation(description: "Expect Failure handler to be called ")
        mocksignupviewDelegate.expectation = expectation
        mockSignupWebservice.shouldRetrunError = true
        // ACT
        sut.processUserSignup(formModel: signupModel)
        // Assert
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(mocksignupviewDelegate.numberOfCallToSignupSuccess, 0)
        XCTAssertEqual(mocksignupviewDelegate.numberOfCallToSignuperror, 1)
        XCTAssertNotNil(mocksignupviewDelegate.signupError)
    }

}

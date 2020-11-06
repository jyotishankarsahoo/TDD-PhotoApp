//
//  MocksignupViewDelegate.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/14/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation
import XCTest
@testable import TDD_PhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {

    var expectation: XCTestExpectation?
    var numberOfCallToSignupSuccess = 0
    var numberOfCallToSignuperror = 0
    var signupError: SignupError?

    func signupSuccessful() {
        expectation?.fulfill()
        numberOfCallToSignupSuccess += 1
    }

    func signupFailed(error: SignupError) {
        signupError = error
        numberOfCallToSignuperror += 1
        expectation?.fulfill()
    }

}

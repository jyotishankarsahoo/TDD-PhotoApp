//
//  MockSignupWebService.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/14/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation
@testable import TDD_PhotoApp

class MockSignupWebService: SignupWebserviceProtocol {
    var isSignupMethodCalled: Bool = false
    var shouldRetrunError: Bool = false

    func signUp(with model: SignupRequestModel, complition: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        isSignupMethodCalled = true
        if shouldRetrunError {
            complition(nil, .requestFailed(description: "Signup request was not successful"))
        } else {
            let responseModel = SignupResponseModel(status: "ok")
            complition(responseModel, nil)
        }
    }
}

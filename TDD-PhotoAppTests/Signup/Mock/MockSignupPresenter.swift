//
//  MockSignupPresenter.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/15/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation
@testable import TDD_PhotoApp

class MockSignupPresenter: SigupPresenterProtocol {
    var isProcessSignupCalled: Bool = false
    var delegate: SignupViewDelegateProtocol!
    required init(validator: SignupModelValidaterProtocol, signupWebService: SignupWebserviceProtocol, delegate: SignupViewDelegateProtocol) {
        self.delegate = delegate
        // TODO:
    }
    
    func processUserSignup(formModel: SignupModel) {
        isProcessSignupCalled = true
        delegate.signupSuccessful()
    }
    
}

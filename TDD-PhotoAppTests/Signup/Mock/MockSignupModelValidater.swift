//
//  MockSignupModelValidater.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/14/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation
@testable import TDD_PhotoApp

class MockSignupModelValidater: SignupModelValidaterProtocol {
    var isFirstNameValid: Bool = false
    var isLastNameValid: Bool = false
    var isEmailValid: Bool = false
    var isPasswordValid: Bool = false
    var isPasswordMatch: Bool = false
    func isFirstNameValid(firstName: String) -> Bool {
        isFirstNameValid = true
        return true
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        isLastNameValid = true
        return true
    }
    
    func isEmailValid(email: String) -> Bool {
        isEmailValid = true
        return true
    }
    
    func isPasswordValid(psw: String) -> Bool {
        isPasswordValid = true
        return true
    }
    
    func isPasswordMatch(password: String, repeatPassword: String) -> Bool {
        isPasswordMatch = true
        return true
    }
}

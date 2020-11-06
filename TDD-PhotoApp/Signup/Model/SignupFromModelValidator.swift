//
//  SignupFromModelValidator.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/13/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

class SignupFromModelValidator: SignupModelValidaterProtocol {
    func isFirstNameValid(firstName: String) -> Bool {
        var isValid = false
        if (SignupConstants.minFirstNameLength ..< SignupConstants.maxFirstNameLength) ~= firstName.count {
            isValid = true
        }
        return isValid
    }
    func isLastNameValid(lastName: String) -> Bool {
        var isValid = false
        if (SignupConstants.minFirstNameLength ..< SignupConstants.maxFirstNameLength) ~= lastName.count {
            isValid = true
        }
        return isValid
    }
    func isEmailValid(email: String) -> Bool {
        var isValid = false
        if email.contains("@") {
            isValid = true
        }
        return isValid
    }
    func isPasswordValid(psw: String) -> Bool {
        var isValid = false
        if !psw.isEmpty && psw.count >= SignupConstants.maxPasswordLength {
            isValid = true
        }
        return isValid
    }
    func isPasswordMatch(password: String, repeatPassword: String) -> Bool {
        return password == repeatPassword
    }
}

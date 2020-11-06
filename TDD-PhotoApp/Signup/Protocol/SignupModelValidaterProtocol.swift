//
//  SignupModelValidaterProtocol.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/14/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

protocol SignupModelValidaterProtocol {
    func isFirstNameValid(firstName: String) -> Bool
    func isLastNameValid(lastName: String) -> Bool
    func isEmailValid(email: String) -> Bool
    func isPasswordValid(psw: String) -> Bool
    func isPasswordMatch(password: String, repeatPassword: String) -> Bool 
}

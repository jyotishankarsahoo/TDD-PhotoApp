//
//  SignupViewDeleagate.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/14/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func signupSuccessful()
    func signupFailed(error: SignupError)
}

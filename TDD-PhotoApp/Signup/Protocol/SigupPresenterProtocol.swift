//
//  SigupPresenterProtocol.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/15/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

protocol SigupPresenterProtocol: AnyObject {
    init(validator: SignupModelValidaterProtocol,
         signupWebService: SignupWebserviceProtocol,
         delegate: SignupViewDelegateProtocol)
    func processUserSignup(formModel: SignupModel)
}

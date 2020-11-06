//
//  SignupRequestModel.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/13/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

struct SignupRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

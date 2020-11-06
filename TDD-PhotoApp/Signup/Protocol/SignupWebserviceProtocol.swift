//
//  SignupWebserviceProtocol.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/14/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

protocol SignupWebserviceProtocol {
    func signUp(with model: SignupRequestModel, complition: @escaping (SignupResponseModel?, SignupError?) -> Void)
}

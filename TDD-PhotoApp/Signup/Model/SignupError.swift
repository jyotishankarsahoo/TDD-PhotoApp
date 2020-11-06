//
//  SignupError.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/13/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
    case invalidJsonResponse
    case invalidURLString
    case requestFailed(description: String)
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case passwordDidNotMatch
    
    var errorDescription: String? {
        switch self {
        case .requestFailed(let description):
            return description
        case .invalidJsonResponse,
             .invalidURLString,
             .invalidEmail,
             .invalidFirstName,
             .invalidLastName,
             .invalidPassword,
             .passwordDidNotMatch:
            return ""
        }
    }
}

//
//  SigupPresenter.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/14/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

class SigupPresenter: SigupPresenterProtocol {

    private var validator: SignupModelValidaterProtocol
    private var signupWebService: SignupWebserviceProtocol
    private weak var delegate: SignupViewDelegateProtocol?

    required init(validator: SignupModelValidaterProtocol,
                  signupWebService: SignupWebserviceProtocol, delegate: SignupViewDelegateProtocol) {
        self.validator = validator
        self.signupWebService = signupWebService
        self.delegate = delegate
    }

    func processUserSignup(formModel: SignupModel) {
        if !validator.isFirstNameValid(firstName: formModel.firstName) {
            delegate?.signupFailed(error: .invalidFirstName)
            return
        }
        if !validator.isLastNameValid(lastName: formModel.lastName) {
            delegate?.signupFailed(error: .invalidLastName)
            return
        }
        if !validator.isEmailValid(email: formModel.email) {
            delegate?.signupFailed(error: .invalidEmail)
            return
        }
        if !validator.isPasswordValid(psw: formModel.password) {
            delegate?.signupFailed(error: .invalidPassword)
            return
        }
        if !validator.isPasswordMatch(password: formModel.password, repeatPassword: formModel.repeatPassword) {
            delegate?.signupFailed(error: .passwordDidNotMatch)
            return
        }
        
        let requestModel = SignupRequestModel(firstName: formModel.firstName, lastName: formModel.lastName, email: formModel.email, password: formModel.password)
        
        signupWebService.signUp(with: requestModel) { [weak self] (signupResponse, signupError) in
            if let error = signupError {
                self?.delegate?.signupFailed(error: error)
                return
            }
            if let _ = signupResponse {
                self?.delegate?.signupSuccessful()
                return
            }
        }
    }
}

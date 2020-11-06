//
//  TDD_PhotoAppTests.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/13/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import XCTest
@testable import TDD_PhotoApp

class SignupFromModelValidatorTests: XCTestCase {
    var sut: SignupFromModelValidator!
    override func setUpWithError() throws {
        sut = SignupFromModelValidator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSignupFromModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        // Arrange is done at set up
        // Act
        let isValid = sut.isFirstNameValid(firstName: "Jyoti")
        // Assert
        XCTAssertTrue(isValid, "The Func isFirstNameValid() should return TRUE for valid first name but returned FALSE")
    }
    func testSignupFromModelValidator_WhenFirstNameIsTooShort_ShouldReturnFalse() {
        // Arrange is done at set up
        // Act
        let isValid = sut.isFirstNameValid(firstName: "J")
        // Assert
        XCTAssertFalse(isValid, "The Func isFirstNameValid should return FALSE for too short first name but returned TRUE")
    }
    func testSignupFromModelValidator_WhenFirstNameIsTooLong_ShouldReturnFalse() {
        // Act
        let isValid = sut.isFirstNameValid(firstName: "JyotiJyoti")
        XCTAssertFalse(isValid, "The Func isFirstNameValid should return FALSE for to long first name but returned TRUE")
    }
    func testSignupFromModelValidator_WhenLastNameisValid_ShouldReturnTrue() {
        // Act
        let isValid = sut.isLastNameValid(lastName: "Sahoo")
        // Assert
        XCTAssertTrue(isValid, "The Func isLastNameValid() should return TRUE for valid last name but returned FALSE")
    }
    func testSignupFromModelValidator_WhenLastNameisTooSmall_ShouldReturnFalse() {
        // Act
        let isValid = sut.isLastNameValid(lastName: "S")
        // Assert
        XCTAssertFalse(isValid, "The Func isLastNameValid() should return FALSE for too short last name but returned TRUE")
    }
    func testSignupFromModelValidator_WhenLastNameisTooLong_ShouldReturnFalse() {
        // Act
        let isValid = sut.isLastNameValid(lastName: "ShankarShankar")
        // Assert
        XCTAssertFalse(isValid, "The Func isLastNameValid() should return FALSE for too Long last name but returned TRUE")
    }
    func testSignupFromModelValidator_WhenEmailisValid_ShouldReturnTrue() {
        // Act
        let isValid = sut.isEmailValid(email: "jsahoo@apple.com")
        // Assert
        XCTAssertTrue(isValid, "The Func isEmailValid() should return TRUE for valid email but returned FALSE")
    }
    func testSignupFromModelValidator_WhenEmailisInValid_ShouldReturnFalse() {
        // ACT
        let isValid = sut.isEmailValid(email: "jsahooapple.com")
        // Assert
        XCTAssertFalse(isValid, "The Func isEmailValid() should return FALSE for In-valid email but returned TRUE")
    }
    func testSignupFromModelValidator_WhenPSWisValid_ShouldReturnTrue() {
        // ACT
        let isValid = sut.isPasswordValid(psw: "12345")
        // Assert
        XCTAssertTrue(isValid, "The Func isPasswordValid() should return TRUE for valid password but returned FALSE")
    }
    func testSignupFromModelValidator_WhenPSWisInValid_ShouldReturnFalse() {
        // ACT
        let isValid = sut.isPasswordValid(psw: "123")
        // Assert
        XCTAssertFalse(isValid, "The Func isPasswordValid() should return FALSE for In-valid password but returned TRUE")
    }
    func testSignupFromModelValidator_WhenEqualPSWProvided_ShouldReturnTrue() {
        // ACT
        let ispswMatch = sut.isPasswordMatch(password: "12345", repeatPassword: "12345")
        // Assert
        XCTAssertTrue(ispswMatch, "The Func isPasswordMatch() should return TRUE for PSW match but returned FALSE")
    }
    func testSignupFromModelValidator_WhenNotEqualPSWProvided_ShouldReturnFalse() {
        // ACT
        let ispswMatch = sut.isPasswordMatch(password: "12345", repeatPassword: "12354")
        // Assert
        XCTAssertFalse(ispswMatch, "The Func isPasswordMatch() should return FALSE for PSW no match but returned TRUE")
    }

}

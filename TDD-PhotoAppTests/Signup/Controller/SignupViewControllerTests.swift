//
//  SignupViewControllerTests.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/15/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import XCTest
@testable import TDD_PhotoApp
class SignupViewControllerTests: XCTestCase {
    var storyBoard: UIStoryboard!
    var signupViewController: SignupViewController!

    override func setUpWithError() throws {
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        signupViewController = storyBoard.instantiateViewController(identifier: "SignupViewController") as? SignupViewController
        signupViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        storyBoard = nil
        signupViewController = nil
    }

    func testSignupViewController_WhenInitialized_AllTextfieldShouldbeEmpty() throws {
        // Arrange
        // Act
        let firstNameTextField = try XCTUnwrap(signupViewController.firstNameTextField, "First Name Text Field is not connected")
        let lastNameTextField = try XCTUnwrap(signupViewController.lastNameTextField, "Last Name Text Field is not connected")
        let emailTextField = try XCTUnwrap(signupViewController.emailTextField, "email Text Field is not connected")
        let passwordTextField = try XCTUnwrap(signupViewController.passwordTextField, "Password Text Field is not connected")
        let rePasswordTextField = try XCTUnwrap(signupViewController.repeatPasswordTextField, "repeat PSW Text Field is not connected")
        // Assert
        XCTAssertTrue(firstNameTextField.text == "", "First Name TextField is not Blank when view loaded for the first time")
        XCTAssertTrue(lastNameTextField.text == "", "Last Name TextField is not Blank when view loaded for the first time")
        XCTAssertTrue(emailTextField.text == "", "Email TextField is not Blank when view loaded for the first time")
        XCTAssertTrue(passwordTextField.text == "", "Password TextField is not Blank when view loaded for the first time")
        XCTAssertTrue(rePasswordTextField.text == "", "repeat PSW TextField is not Blank when view loaded for the first time")
    }
    func testSignupViewController_whenCreated_signupButtonHasAction() throws {
        // Arrange
        let unwrappedSignupButton = try XCTUnwrap(signupViewController.signupButton, "SignupButton is not connected")
        // Act
        let actionsConnected = unwrappedSignupButton.actions(forTarget: signupViewController, forControlEvent: .touchUpInside)
        // Assert
        XCTAssertTrue(actionsConnected?.count == 1, "No action connected to Signup button")
        XCTAssertEqual(actionsConnected?.first, "signupButtonTappedWithSender:", "signup button is connected to any action")
    }
    func testSignupViewController_WhenSignupButtonPressed_invokeProcessSignup() {
        // Arrange
        let signupModelValidator = MockSignupModelValidater()
        let signupWebService = MockSignupWebService()
        let mockSignupViewDelegate = MockSignupViewDelegate()
        let mockSignupPresenter = MockSignupPresenter(validator: signupModelValidator, signupWebService: signupWebService, delegate: mockSignupViewDelegate)
        signupViewController.signupPresenter = mockSignupPresenter
        // Act
        signupViewController.signupButton.sendActions(for: .touchUpInside)
        // Assert
        XCTAssertTrue(mockSignupPresenter.isProcessSignupCalled)
    }
    func testSignupViewController_EmailTextField_hasEmailContentType() throws {
        // Arrange
        let emailTextField: UITextField = try XCTUnwrap(signupViewController.emailTextField, "emailTextField is not connected")
        // ACT Assert
        XCTAssertTrue(emailTextField.textContentType == UITextContentType.emailAddress, "Email Text field doesn't have email content type")
        XCTAssertTrue(emailTextField.keyboardType == .emailAddress, "Email Text field doesn't have email Keyboard Type")
        XCTAssertTrue(emailTextField.placeholder == "Email", "Email Text field doesn't have email Keyboard Type")
    }
    func testSignupViewController_WhenSignupSucceed_SecondViewControllerIsShown() {
        let nv = UINavigationController(rootViewController: signupViewController)
        let signupModelValidator = MockSignupModelValidater()
        let signupWebService = MockSignupWebService()
        signupViewController.signupPresenter = MockSignupPresenter(validator: signupModelValidator, signupWebService: signupWebService, delegate: signupViewController)
        signupViewController.signupButton.sendActions(for: .touchUpInside)
        RunLoop.current.run(until: Date())
        guard let _ = nv.topViewController as? SecondViewController else {
            XCTFail("Second View Controller is not pushed")
            return
        }
    }
    func testSignupViewController_WhenSignupSucceed_SecondViewControllerIsShownV2() {
        let signupModelValidator = MockSignupModelValidater()
        let signupWebService = MockSignupWebService()
        signupViewController.signupPresenter = MockSignupPresenter(validator: signupModelValidator, signupWebService: signupWebService, delegate: signupViewController)
        let spyNavigationController = SpyNavigationController(rootViewController: signupViewController)
        signupViewController.signupButton.sendActions(for: .touchUpInside)
        guard let _ = spyNavigationController.pushedViewController as? SecondViewController else {
            XCTFail("Second View Controller is not pushed")
            return
        }
    }
    func testSignupViewController_WhenSignupSucceed_SecondViewControllerIsShownV3() {
        let signupModelValidator = MockSignupModelValidater()
        let signupWebService = MockSignupWebService()
        signupViewController.signupPresenter = MockSignupPresenter(validator: signupModelValidator, signupWebService: signupWebService, delegate: signupViewController)
        let spyNavigationController = SpyNavigationController(rootViewController: signupViewController)
        signupViewController.signupButton.sendActions(for: .touchUpInside)
        guard let _ = spyNavigationController.pushedViewController as? SecondViewController else {
            XCTFail("Second View Controller is not pushed")
            return
        }
    }
}

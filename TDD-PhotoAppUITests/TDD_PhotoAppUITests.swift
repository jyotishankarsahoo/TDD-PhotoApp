//
//  TDD_PhotoAppUITests.swift
//  TDD-PhotoAppUITests
//
//  Created by Jyoti Sahoo on 11/2/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import XCTest

final class TDD_PhotoAppUITests: XCTestCase {

    var app: XCUIApplication!
    var userNameTextField: XCUIElement!
    var lastNameTextField: XCUIElement!
    var emailTextField: XCUIElement!
    var pswTextField: XCUIElement!
    var repeatePSWTextField: XCUIElement!
    var signupButton: XCUIElement!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments = ["-skipSurvey"]
        if let url = ProcessInfo.processInfo.environment["signupURL"] {
            app.launchEnvironment = ["signupURL": url, "inAppPurchaseEable": "true"]
        }
        app.launch()
        userNameTextField = app.textFields["firstName"]
        lastNameTextField = app.textFields["lastName"]
        emailTextField = app.textFields["email"]
        pswTextField = app.secureTextFields["password"]
        repeatePSWTextField = app.secureTextFields["repassword"]
        signupButton = app.buttons["signup"]
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        userNameTextField = nil
        lastNameTextField = nil
        emailTextField = nil
        pswTextField = nil
        repeatePSWTextField = nil
        signupButton = nil
        continueAfterFailure = false
    }

    func testSignupVC_whenViewloaded_requiredElementsAreEnabled() throws {
        //ACT & ASSERT
        XCTAssertTrue(userNameTextField.isEnabled, "Unable to find UserName TextField")
        XCTAssertTrue(lastNameTextField.isEnabled, "Unable to find LastName TextField")
        XCTAssertTrue(emailTextField.isEnabled, "Unable to find email TextField")
        XCTAssertTrue(pswTextField.isEnabled, "Unable to find Password TextField")
        XCTAssertTrue(repeatePSWTextField.isEnabled, "Unable to find repeat PSW TextField")
        XCTAssertTrue(signupButton.isEnabled, "Unable to find Signup Button")
    }
    
    func testSignupVC_whenInvalidFormMdoelSubmitted_ErrorAlertShown() {
        // Act
        userNameTextField.tap()
        userNameTextField.typeText("L")
        lastNameTextField.tap()
        lastNameTextField.typeText("Forgusion")
        emailTextField.tap()
        emailTextField.typeText("test@gmail.com")
        pswTextField.tap()
        pswTextField.typeText("12345678")
        repeatePSWTextField.tap()
        repeatePSWTextField.typeText("12345678")
        signupButton.tap()
        let emailTextFieldScreenShot = XCUIScreen.main.screenshot()
        let emailTextFieldAttachment = XCTAttachment(screenshot: emailTextFieldScreenShot)
        emailTextFieldAttachment.lifetime = .keepAlways
        add(emailTextFieldAttachment)
        // Assert
        let alert = app.alerts["errorAlertDialog"]
        XCTAssertTrue(alert.exists, "Error alert is not presented when Invalid Form model is Submitted")
        
    }
    func testSignupVC_whenValidFormMdoelSubmitted_SuccessAlertShown() {
        // Act
        userNameTextField.tap()
        userNameTextField.typeText("Loki")
        lastNameTextField.tap()
        lastNameTextField.typeText("Forgusion")
        emailTextField.tap()
        emailTextField.typeText("test@gmail.com")
        pswTextField.tap()
        pswTextField.typeText("12345678")
        repeatePSWTextField.tap()
        repeatePSWTextField.typeText("12345678")
        signupButton.tap()
        // Assert
        let alert = app.alerts["successAlertDialog"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "Error alert is not presented when Invalid Form model is Submitted")
    }
    func testSignupVC_onDismissingSuccessAlert_SecondVCShown() {
        // Act
        userNameTextField.tap()
        userNameTextField.typeText("Loki")
        lastNameTextField.tap()
        lastNameTextField.typeText("Forgusion")
        emailTextField.tap()
        emailTextField.typeText("test@gmail.com")
        pswTextField.tap()
        pswTextField.typeText("12345678")
        repeatePSWTextField.tap()
        repeatePSWTextField.typeText("12345678")
        signupButton.tap()
        let alert = app.alerts["successAlertDialog"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "Error alert is not presented when Invalid Form model is Submitted")
        let okButton = alert.buttons.element(boundBy: 0)
        okButton.tap()
         // Assert
        XCTAssertTrue(app.otherElements["SecondViewController"].waitForExistence(timeout: 3), "Second View Controller is not shown after successful Login")
    }
}

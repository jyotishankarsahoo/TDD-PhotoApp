//
//  SignupViewController.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/15/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var repeatPasswordTextField: UITextField!
    @IBOutlet var signupButton: UIButton!
    var signupPresenter: SigupPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-skipSurvey") {
            print("Survey Page Skipped")
        }
        #endif
        if signupPresenter == nil {
            let signUpURL = ProcessInfo.processInfo.environment["signupURL"] ?? SignupConstants.signupURLString
            signupPresenter = SigupPresenter(validator: SignupFromModelValidator(),
                                             signupWebService: SignupWebService(urlString: signUpURL),
                                             delegate: self)
        }
    }

    @IBAction func signupButtonTapped(sender: UIButton) {
        let signupModel = SignupModel(firstName: firstNameTextField.text ?? "",
                                      lastName: lastNameTextField.text ?? "",
                                      email: emailTextField.text ?? "",
                                      password: passwordTextField.text ?? "",
                                      repeatPassword: repeatPasswordTextField.text ?? "")
        signupPresenter?.processUserSignup(formModel: signupModel)
    }
}

extension SignupViewController: SignupViewDelegateProtocol {
    func signupSuccessful() {        
        let alertController = UIAlertController(title: "Success", message: "The sign up operation is successful", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
            let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondViewController")
            secondVC.view.accessibilityIdentifier = "SecondViewController"
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
        alertController.addAction(alertAction)
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func signupFailed(error: SignupError) {
        let alertController = UIAlertController(title: "Error", message: "Your Request Cannot be processed at this time" , preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

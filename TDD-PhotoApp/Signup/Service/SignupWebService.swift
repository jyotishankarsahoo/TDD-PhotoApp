//
//  SignupWebService.swift
//  TDD-PhotoApp
//
//  Created by Jyoti Sahoo on 10/13/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import Foundation

class SignupWebService: SignupWebserviceProtocol {

    private var urlString: String
    private var urlSession: URLSession

    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    func signUp(with model: SignupRequestModel, complition: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        guard let url = URL(string: urlString) else {
            complition(nil, .invalidURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(model)
        
        let dataTask = urlSession.dataTask(with: request) { (data, resposne, error) in
            // TODO: Write Unit Test handle Error
            if let requestError = error {
                DispatchQueue.main.async {
                complition(nil, .requestFailed(description: requestError.localizedDescription))
                }
                return
            }
            if let data = data, let signupResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                DispatchQueue.main.async {
                    complition(signupResponseModel, nil)
                }
            } else {
                // TODO: Write Unit Test to handle Decoding Error
                DispatchQueue.main.async {
                complition(nil, .invalidJsonResponse)
                }
            }
        }
        dataTask.resume()
    }
}

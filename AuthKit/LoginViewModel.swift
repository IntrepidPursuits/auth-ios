//
//  LoginViewModel.swift
//  AuthKit
//
//  Created by Mark Daigneault on 2/14/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import Intrepid
import RxSwift

protocol AuthAPIClient {
    func login(email: String, password: String, completion: (Result<AuthResponse>) -> Void)
}

enum AuthError: Error {
    case emptyFields
    case invalidEmail
    case apiClientError(Error)
}

struct LoginViewModel {

    var apiClient: AuthAPIClient!
    var userManager: UserManager = .shared

    var email: Variable<String?> = Variable(nil)
    var password: Variable<String?> = Variable(nil)

    var isSubmitButtonEnabled: Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), password.asObservable()) { (email, password) in
            return email != nil && password != nil
        }
    }

    func attemptLogIn(completion: (Result<Void>) -> Void) {
        guard
            let email = email.value, !email.ip_isEmptyOrWhitespace(),
            let password = password.value, !password.ip_isEmptyOrWhitespace()
        else {
            completion(.failure(AuthError.emptyFields))
            return
        }

        guard email.ip_isValidEmail() else {
            completion(.failure(AuthError.invalidEmail))
            return
        }

        apiClient.login(email: email, password: password) { result in
            switch result {
            case .success:
                self.userManager.acceptSuccessfulEmailLogin(email: email, password: password, result: result)
                completion(.success())
            case .failure(let error):
                completion(.failure(AuthError.apiClientError(error)))
            }
        }
    }
}

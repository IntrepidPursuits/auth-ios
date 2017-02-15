//
//  UserManager.swift
//  AuthKit
//
//  Created by Mark Daigneault on 2/14/17.
//  Copyright © 2017 Intrpeid Pursuits. All rights reserved.
//

import Intrepid
import KeychainAccess

class UserManager {

    static let shared = UserManager(keychainService: "shared")

    var user: User?

    private let keychainService: String
    private lazy var keychain: Keychain = Keychain(service: self.keychainService)

    private let emailKey = "email"
    private let passwordKey = "password"
    private let authKey = "authToken"

    private let providerKey = "provider"
    private let uidKey = "uid"
    private let tokenKey = "token"
    private let tokenExpirationDateKey = "token_expires_at"

    var signedIn: Bool {
        return getAuthToken() != nil
    }

    init(keychainService: String) {
        self.keychainService = keychainService
    }

    func storeEmailCredentials(email: String, password: String) {
        keychain[emailKey] = email
        keychain[passwordKey] = password
    }

    func storeFacebookCredentials(provider: String, uid: String, token: String, tokenExpirationDate: String) {
        keychain[providerKey] = provider
        keychain[uidKey] = uid
        keychain[tokenKey] = token
        keychain[tokenExpirationDateKey] = tokenExpirationDate
    }

    func storeAuthToken(_ authToken: String) {
        keychain[authKey] = authToken
    }

    func getEmail() -> String? {
        return keychain[emailKey]
    }

    func getPassword() -> String? {
        return keychain[passwordKey]
    }

    func getAuthToken() -> String? {
        return keychain[authKey]
    }

    // MARK: - Log in / Log out

    func acceptSuccessfulEmailLogin(email: String, password: String, result: Result<AuthResponse>) {
        if let authResponse = result.value {
            self.storeEmailCredentials(email: email, password: password)
            self.storeAuthToken(authResponse.token)
        }
    }

    func acceptSuccessfulFacebookLogin(provider: String, uid: String, token: String, tokenExpirationDate: String, result: Result<AuthResponse>) {
        if let authResponse = result.value {
            self.storeFacebookCredentials(provider: provider, uid: uid, token: token, tokenExpirationDate: tokenExpirationDate)
            self.storeAuthToken(authResponse.token)
        }
    }

    func logout() {
        keychain[emailKey] = nil
        keychain[passwordKey] = nil
        keychain[authKey] = nil

        user = nil
    }
}

//
//  User.swift
//  AuthKit
//
//  Created by Mark Daigneault on 2/14/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

// MARK: - User

struct User {
    let identifier: String
    let email: String
}

struct AuthenticationUser {
    let email: String
    let password: String
}

//
//  AuthResponse.swift
//  AuthKit
//
//  Created by Mark Daigneault on 2/14/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Genome

struct AuthResponse: MappableObject {
    let userId: String
    let token: String

    init(map: Map) throws {
        userId = try map.extract("user_id")
        token = try map.extract("authentication_token")
    }
}

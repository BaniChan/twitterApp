//
//  AuthRepositoryProtocol+Extension.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import FirebaseAuth

@testable import TwiterApp

extension AuthRepositoryProtocol {
    var loggedIn: Bool {
        false
    }
    
    var displayName: String? {
        "test user"
    }
    
    var userId: String? {
        "user id 0"
    }
    
    func createUser(displayName: String, email: String, password: String, completion: ((Bool, Error?) -> Void)?) {}
    
    func login(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {}
    
    func logout() throws {}
}

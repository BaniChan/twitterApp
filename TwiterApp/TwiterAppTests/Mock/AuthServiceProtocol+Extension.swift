//
//  AuthServiceProtocol+Extension.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import UIKit

@testable import TwiterApp

extension AuthServiceProtocol {
    func currentUser() -> UserData? {
        UserData.mockUser
    }
    
    func createUser(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {}
    func login(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {}
    func logout() throws {}
    func setDisplayName(_ displayName: String) {}
}

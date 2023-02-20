//
//  UserData+Extension.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation

@testable import TwiterApp

extension UserData {
    static var mockUser: UserData {
        UserData(userId: "user 0", displayName: "user zero", email: "user@user.com")
    }
}

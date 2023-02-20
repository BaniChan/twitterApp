//
//  UserData.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import FirebaseAuth

struct UserData {
    let userId: String
    var displayName: String
    var email: String
    
    init(
        userId: String,
        displayName: String,
        email: String
    ) {
        self.userId = userId
        self.displayName = displayName
        self.email = email
    }
    
    init(_ user: User) {
        userId = user.uid
        displayName = user.displayName ?? ""
        email = user.email ?? ""
    }
}

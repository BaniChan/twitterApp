//
//  AuthService.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import FirebaseAuth

protocol AuthServiceProtocol {
    func currentUser() -> UserData?
    func createUser(email: String, password: String, completion: ((Bool, Error?) -> Void)?)
    func login(email: String, password: String, completion: ((Bool, Error?) -> Void)?)
    func logout() throws
    func setDisplayName(_ displayName: String)
}

class AuthService: AuthServiceProtocol {
    func currentUser() -> UserData? {
        guard let currentUser = Auth.auth().currentUser else { return nil }
        return UserData(currentUser)
    }
    
    func createUser(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            completion?(result != nil, error)
        }
    }
    
    func login(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion?(result != nil, error)
        }
    }
    
    func logout() throws {
        try? Auth.auth().signOut()
    }
    
    func setDisplayName(_ displayName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges()
    }
}

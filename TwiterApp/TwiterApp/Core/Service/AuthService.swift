//
//  AuthService.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import FirebaseAuth

protocol AuthServiceProtocol {
    func currentUser() -> User?
    func createUser(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func login(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func logout() throws
    func setDisplayName(_ displayName: String)
}

class AuthService: AuthServiceProtocol {
    func currentUser() -> User? {
        Auth.auth().currentUser
    }
    
    func createUser(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func login(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
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

//
//  FirebaseAuthService.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import FirebaseAuth

protocol FirebaseAuthServiceProtocol {
//    func addAuthStateDidChangeListener(_ listener: @escaping (Auth, User?) -> Void) -> AuthStateDidChangeListenerHandle
//    func removeStateDidChangeListener(_ handle: AuthStateDidChangeListenerHandle)
    func currentUser() -> User?
    func createUser(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func signIn(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func signOut() throws
    func setDisplayName(_ displayName: String)
}

class FirebaseAuthService: FirebaseAuthServiceProtocol {
//    func addAuthStateDidChangeListener(_ listener: @escaping (Auth, User?) -> Void) -> AuthStateDidChangeListenerHandle {
//        Auth.auth().addIDTokenDidChangeListener(listener)
//    }
//    
//    func removeStateDidChangeListener(_ handle: AuthStateDidChangeListenerHandle) {
//        Auth.auth().removeStateDidChangeListener(handle)
//    }
    
    func currentUser() -> User? {
        Auth.auth().currentUser
    }
    
    func createUser(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func signIn(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func signOut() throws {
        try? Auth.auth().signOut()
    }
    
    func setDisplayName(_ displayName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges()
    }
}

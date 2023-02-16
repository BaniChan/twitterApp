//
//  AuthRepository.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import FirebaseAuth
import Resolver

protocol AuthRepositoryProtocol {
    func addAuthStateDidChangeListener(_ listener: @escaping (Auth, FirebaseAuth.User?) -> Void) -> AuthStateDidChangeListenerHandle
    func removeStateDidChangeListener(_ handle: AuthStateDidChangeListenerHandle)
    func createUser(
        email: String,
        displayName: String,
        password: String,
        completion: ((AuthDataResult?, Error?) -> Void)?)
    func signIn(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func signOut() throws
}

class AuthRepository: AuthRepositoryProtocol {
    @Injected private var firebaseAuthService: FirebaseAuthServiceProtocol
    
    func addAuthStateDidChangeListener(_ listener: @escaping (Auth, FirebaseAuth.User?) -> Void) -> AuthStateDidChangeListenerHandle {
        firebaseAuthService.addAuthStateDidChangeListener(listener)
    }
    
    func removeStateDidChangeListener(_ handle: AuthStateDidChangeListenerHandle) {
        firebaseAuthService.removeStateDidChangeListener(handle)
    }
    
    func createUser(
        email: String,
        displayName: String,
        password: String,
        completion: ((AuthDataResult?, Error?) -> Void)?) {
            firebaseAuthService.createUser(
                email: email,
                password: password) { [weak self] result, error in
                self?.setDisplayName(displayName)
                completion?(result, error)
            }
    }
    
    func signIn(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        firebaseAuthService.signIn(email: email, password: password, completion: completion)
    }
    
    func signOut() throws {
        try? firebaseAuthService.signOut()
    }
    
    private func setDisplayName(_ displayName: String) {
        firebaseAuthService.setDisplayName(displayName)
    }
}

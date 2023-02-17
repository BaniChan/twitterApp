//
//  AuthRepository.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import FirebaseAuth
import Resolver

protocol AuthRepositoryProtocol {
    var loggedIn: Bool { get }
    func createUser(
        displayName: String,
        email: String,
        password: String,
        completion: ((AuthDataResult?, Error?) -> Void)?)
    func signIn(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func signOut() throws
}

class AuthRepository: AuthRepositoryProtocol {
    @Injected private var authService: AuthServiceProtocol
    
    var loggedIn: Bool {
        Auth.auth().currentUser != nil
    }
    
    func createUser(
        displayName: String,
        email: String,
        password: String,
        completion: ((AuthDataResult?, Error?) -> Void)?) {
            authService.createUser(
                email: email,
                password: password) { [weak self] result, error in
                self?.setDisplayName(displayName)
                completion?(result, error)
            }
    }
    
    func signIn(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        authService.signIn(email: email, password: password, completion: completion)
    }
    
    func signOut() throws {
        try? authService.signOut()
    }
    
    private func setDisplayName(_ displayName: String) {
        authService.setDisplayName(displayName)
    }
}

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
    var currentUser: User? { get }
    func createUser(
        displayName: String,
        email: String,
        password: String,
        completion: ((AuthDataResult?, Error?) -> Void)?)
    func login(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func logout() throws
}

class AuthRepository: AuthRepositoryProtocol {
    @Injected private var authService: AuthServiceProtocol
    
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
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
    
    func login(email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        authService.login(email: email, password: password, completion: completion)
    }
    
    func logout() throws {
        try? authService.logout()
    }
    
    private func setDisplayName(_ displayName: String) {
        authService.setDisplayName(displayName)
    }
}

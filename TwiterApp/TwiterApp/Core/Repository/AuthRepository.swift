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
    var displayName: String? { get }
    var userId: String? { get }
    func createUser(
        displayName: String,
        email: String,
        password: String,
        completion: ((Bool, Error?) -> Void)?)
    func login(email: String, password: String, completion: ((Bool, Error?) -> Void)?)
    func logout() throws
}

class AuthRepository: AuthRepositoryProtocol {
    @Injected private var authService: AuthServiceProtocol
    
    var displayName: String? {
        Auth.auth().currentUser?.displayName
    }
    
    var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    var loggedIn: Bool {
        Auth.auth().currentUser != nil
    }
    
    func createUser(
        displayName: String,
        email: String,
        password: String,
        completion: ((Bool, Error?) -> Void)?) {
            authService.createUser(
                email: email,
                password: password) { [weak self] result, error in
                self?.setDisplayName(displayName)
                completion?(result != nil, error)
            }
    }
    
    func login(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {
        authService.login(email: email, password: password) { result, error in
            completion?(result != nil, error)
        }
    }
    
    func logout() throws {
        try? authService.logout()
    }
    
    private func setDisplayName(_ displayName: String) {
        authService.setDisplayName(displayName)
    }
}

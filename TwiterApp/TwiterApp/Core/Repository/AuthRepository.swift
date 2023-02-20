//
//  AuthRepository.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

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
        authService.currentUser()?.displayName
    }
    
    var userId: String? {
        authService.currentUser()?.userId
    }
    
    var loggedIn: Bool {
        authService.currentUser() != nil
    }
    
    func createUser(
        displayName: String,
        email: String,
        password: String,
        completion: ((Bool, Error?) -> Void)?) {
            authService.createUser(
                email: email,
                password: password) { [weak self] success, error in
                self?.setDisplayName(displayName)
                completion?(success, error)
            }
    }
    
    func login(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {
        authService.login(email: email, password: password, completion: completion)
    }
    
    func logout() throws {
        try? authService.logout()
    }
    
    private func setDisplayName(_ displayName: String) {
        authService.setDisplayName(displayName)
    }
}

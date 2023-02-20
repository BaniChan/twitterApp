//
//  AuthRepositoryTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import XCTest
import Resolver

@testable import TwiterApp

final class AuthRepositoryTest: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testLogin() throws {
        let authService = AuthServiceMock()
        Resolver.test.register { authService as AuthServiceProtocol }
        
        // without login
        let authRepository = AuthRepository()
        XCTAssertFalse(authRepository.loggedIn)
        
        // login failed
        authService.loginSuccess = false
        authRepository.login(email: "user0@user.com", password: "password") { result, error in
            XCTAssertFalse(result)
        }
        XCTAssertFalse(authRepository.loggedIn)
        
        // login success
        authService.loginSuccess = true
        authRepository.login(email: "user0@user.com", password: "password") { result, error in
            XCTAssertTrue(result)
        }
        XCTAssertTrue(authRepository.loggedIn)
        let mockUser = UserData.mockUser
        XCTAssertEqual(authRepository.userId, mockUser.userId)
        XCTAssertEqual(authRepository.displayName, mockUser.displayName)
        
        // logout
        try? authRepository.logout()
        XCTAssertTrue(authService.hasLogout)
        XCTAssertFalse(authRepository.loggedIn)

    }
    
    func testCreateUser() throws {
        let authService = AuthServiceMock()
        Resolver.test.register { authService as AuthServiceProtocol }
        
        // create failed
        let authRepository = AuthRepository()
        authService.createSuccess = false
        let displayName = "kai"
        authRepository.createUser(displayName: displayName, email: "user0@user.com", password: "password") { result, error in
            XCTAssertFalse(result)
        }
        
        // create success
        authService.createSuccess = true
        authRepository.createUser(displayName: displayName, email: "user0@user.com", password: "password") { result, error in
            XCTAssertTrue(result)
        }
        XCTAssertEqual(authService.createUserDisplayName, displayName)
    }
    
    private class AuthServiceMock: AuthServiceProtocol {
        enum AuthServicError: Error {
            case createError
            case loginError
        }
        
        var user: UserData? = nil
        var hasLogout = false
        var createSuccess = false
        var loginSuccess = false
        var createUserDisplayName = ""
        
        func currentUser() -> UserData? {
            user
        }
        
        func createUser(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {
            guard createSuccess else {
                completion?(createSuccess, AuthServicError.createError)
                return
            }
            completion?(createSuccess, nil)
        }
        
        func login(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {
            guard loginSuccess else {
                completion?(loginSuccess, AuthServicError.loginError)
                return
            }
            user = UserData.mockUser
            user?.email = email
            completion?(loginSuccess, nil)
        }
        
        func logout() throws {
            user = nil
            hasLogout = true
        }
        
        func setDisplayName(_ displayName: String) {
            createUserDisplayName = displayName
        }
    }
}

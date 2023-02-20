//
//  LoginViewModelTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import XCTest
import Resolver

@testable import TwiterApp

final class LoginViewModelTest: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testLogin() throws {
        let authRepository = AuthRepositoryMock()
        Resolver.test.register { authRepository as AuthRepositoryProtocol }
        
        var loginSucces = false
        let outputMock = LoginViewModelOutputMock()
        let viewModel = LoginViewModel(loginSuccessCallback: { loginSucces = true })
        viewModel.viewController = outputMock
        
        // init status
        viewModel.textFieldEditingChanged()
        XCTAssertFalse(outputMock.isEnableLoginButton)
        
        // without password
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = ""
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.hasErrorMsg)
        XCTAssertFalse(outputMock.isEnableLoginButton)
        
        // without email
        outputMock.emailInput = ""
        outputMock.passwordInput = "123456"
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.hasErrorMsg)
        XCTAssertFalse(outputMock.isEnableLoginButton)
        
        // wrong email
        outputMock.emailInput = "test"
        outputMock.passwordInput = "12345"
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.hasErrorMsg)
        XCTAssertFalse(outputMock.isEnableLoginButton)
        
        // wrong password length
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = "12345"
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.hasErrorMsg)
        XCTAssertFalse(outputMock.isEnableLoginButton)
        
        // login success
        authRepository.loginSuccess = true
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = "123456"
        viewModel.textFieldEditingChanged()
        viewModel.clickLoginButton()
        XCTAssertTrue(outputMock.isEnableLoginButton)
        XCTAssertFalse(outputMock.isLoading)
        XCTAssertTrue(loginSucces)
        
        // login failed
        authRepository.loginSuccess = false
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = "123456"
        viewModel.textFieldEditingChanged()
        viewModel.clickLoginButton()
        XCTAssertTrue(outputMock.isEnableLoginButton)
        XCTAssertFalse(outputMock.isLoading)
        XCTAssertTrue(outputMock.hasErrorMsg)
    }
    
    private class LoginViewModelOutputMock: LoginViewModelOutput {
        var emailInput = ""
        var passwordInput = ""
        var hasErrorMsg = false
        var isEnableLoginButton = false
        var isLoading = false
        
        var email: String? {
            emailInput
        }
        
        var password: String? {
            passwordInput
        }
        
        func showError(_ error: String?) {
            hasErrorMsg = true
        }
        
        func enableLoginButton(_ enable: Bool) {
            isEnableLoginButton = enable
        }
        
        func showLoading(_ show: Bool) {
            isLoading = show
        }
    }
    
    private class AuthRepositoryMock: AuthRepositoryProtocol {
        enum AuthRepositoryError: Error {
            case loginError
        }
        
        var loginSuccess = false
        
        func login(email: String, password: String, completion: ((Bool, Error?) -> Void)?) {
            guard loginSuccess else {
                completion?(loginSuccess, AuthRepositoryError.loginError)
                return
            }
            completion?(loginSuccess, nil)
        }
    }
}

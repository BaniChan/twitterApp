//
//  CreateAccountViewModelTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import XCTest
import Resolver

@testable import TwiterApp

final class CreateAccountViewModelTest: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testCreateAccount() throws {
        let authRepository = AuthRepositoryMock()
        Resolver.test.register { authRepository as AuthRepositoryProtocol }
        
        var createSuccess = false
        let outputMock = CreateAccountViewModelOutputMock()
        let viewModel = CreateAccountViewModel(createSuccessCallback: { createSuccess = true })
        viewModel.viewController = outputMock
        
        // init status
        viewModel.textFieldEditingChanged()
        XCTAssertFalse(outputMock.isEnableCreateButton)
        
        // without confirm password
        outputMock.nameInput = "user"
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = "111111"
        outputMock.confirmPasswordInput = ""
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.isShowError)
        XCTAssertFalse(outputMock.isEnableCreateButton)
        
        // without confirm password
        outputMock.nameInput = "user"
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = ""
        outputMock.confirmPasswordInput = "123456"
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.isShowError)
        XCTAssertFalse(outputMock.isEnableCreateButton)
        
        // without email
        outputMock.nameInput = "user"
        outputMock.emailInput = ""
        outputMock.passwordInput = "123456"
        outputMock.confirmPasswordInput = "123456"
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.isShowError)
        XCTAssertFalse(outputMock.isEnableCreateButton)
        
        // without name
        outputMock.nameInput = ""
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = "123456"
        outputMock.confirmPasswordInput = "123456"
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.isShowError)
        XCTAssertFalse(outputMock.isEnableCreateButton)
        
        // wrong email
        outputMock.nameInput = "user"
        outputMock.emailInput = "test"
        outputMock.passwordInput = "123456"
        outputMock.confirmPasswordInput = "123456"
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.isShowError)
        XCTAssertFalse(outputMock.isEnableCreateButton)
        
        // wrong password length
        outputMock.nameInput = "user"
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = "12345"
        outputMock.confirmPasswordInput = "12345"
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.isShowError)
        XCTAssertFalse(outputMock.isEnableCreateButton)
        
        // password not match
        outputMock.nameInput = "user"
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = "123456"
        outputMock.confirmPasswordInput = "987654"
        viewModel.textFieldEditingChanged()
        XCTAssertTrue(outputMock.isShowError)
        XCTAssertFalse(outputMock.isEnableCreateButton)
        
        // create success
        authRepository.createSuccess = true
        outputMock.nameInput = "user"
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = "123456"
        outputMock.confirmPasswordInput = "123456"
        viewModel.textFieldEditingChanged()
        viewModel.clickCreateButton()
        XCTAssertTrue(outputMock.isEnableCreateButton)
        XCTAssertFalse(outputMock.isLoading)
        XCTAssertTrue(createSuccess)
        
        // create failed
        authRepository.createSuccess = false
        outputMock.nameInput = "user"
        outputMock.emailInput = "test@test.cc"
        outputMock.passwordInput = "123456"
        outputMock.confirmPasswordInput = "123456"
        viewModel.textFieldEditingChanged()
        viewModel.clickCreateButton()
        XCTAssertTrue(outputMock.isEnableCreateButton)
        XCTAssertFalse(outputMock.isLoading)
        XCTAssertTrue(outputMock.isShowError)
    }
    
    private class CreateAccountViewModelOutputMock: CreateAccountViewModelOutput {
        var nameInput = ""
        var emailInput = ""
        var passwordInput = ""
        var confirmPasswordInput = ""
        var isShowError = false
        var isEnableCreateButton = false
        var isLoading = false
        
        var name: String? {
            nameInput
        }
        
        var email: String? {
            emailInput
        }
        
        var password: String? {
            passwordInput
        }
        
        var confirmPassword: String? {
            confirmPasswordInput
        }
        
        func showError(_ error: String?) {
            isShowError = true
        }
        
        func enableCreateButton(_ enable: Bool) {
            isEnableCreateButton = enable
        }
        
        func showLoading(_ show: Bool) {
            isLoading = show
        }
    }
    
    private class AuthRepositoryMock: AuthRepositoryProtocol {
        enum AuthRepositoryError: Error {
            case createError
        }
        
        var createSuccess = false
        
        func createUser(displayName: String, email: String, password: String, completion: ((Bool, Error?) -> Void)?) {
            guard createSuccess else {
                completion?(createSuccess, AuthRepositoryError.createError)
                return
            }
            completion?(createSuccess, nil)
        }
    }
}

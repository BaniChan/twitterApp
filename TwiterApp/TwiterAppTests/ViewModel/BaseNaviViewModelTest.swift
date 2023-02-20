//
//  BaseNaviViewModelTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import XCTest
import Resolver

@testable import TwiterApp

final class BaseNaviViewModelTest: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testHandleUserLoggedIn() throws {
        let authRepository = AuthRepositoryMock()
        Resolver.test.register { authRepository as AuthRepositoryProtocol }
        Resolver.test.register { PostRepositoryMock() as PostRepositoryProtocol }
        
        let outputMock = BaseNaviViewModelOutputMock()
        let viewModel = BaseNaviViewModel()
        viewModel.viewController = outputMock
        viewModel.handleUserLoggedIn()
        
        // user not logged in, show welcome screen
        XCTAssertTrue(outputMock.hasShowWelcomeView)
     
        // user logged in, show home screen
        authRepository.isLoggedIn = true
        viewModel.handleUserLoggedIn()
        
        XCTAssertTrue(outputMock.hasShowHomeView)
    }
    
    private class BaseNaviViewModelOutputMock: BaseNaviViewModelOutput {
        var hasShowWelcomeView = false
        var hasShowHomeView = false
        
        func showWelcomeView(loginSuccessCallback: @escaping () -> Void) {
            hasShowWelcomeView = true
        }
        
        func showHomeView(logoutCallback: @escaping () -> Void) {
            hasShowHomeView = true
        }
    }
    
    private class AuthRepositoryMock: AuthRepositoryProtocol {
        var isLoggedIn = false
        var loggedIn: Bool {
            isLoggedIn
        }
    }
    
    private class PostRepositoryMock: PostRepositoryProtocol {}
}

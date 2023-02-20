//
//  WelcomeViewModelTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import XCTest

@testable import TwiterApp

final class WelcomeViewModelTest: XCTestCase {
    func testClickButtons() throws {
        let outputMock = WelcomeViewModelOutputMock()
        let viewModel = WelcomeViewModel(loginSuccessCallback: {})
        viewModel.viewController = outputMock
        viewModel.clickCreateAccountButton()
        
        XCTAssertTrue(outputMock.hasShowCreateAccountView)
     
        viewModel.clickLoginButton()
        
        XCTAssertTrue(outputMock.hasShowLoginView)
    }
    
    private class WelcomeViewModelOutputMock: WelcomeViewModelOutput {
        var hasShowCreateAccountView = false
        var hasShowLoginView = false
        
        func showCreateAccountView(createSuccessCallback: @escaping () -> Void) {
            hasShowCreateAccountView = true
        }
        
        func showLoginView(loginSuccessCallback: @escaping () -> Void) {
            hasShowLoginView = true
        }
    }
}

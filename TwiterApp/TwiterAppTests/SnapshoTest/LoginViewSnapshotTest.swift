//
//  LoginViewSnapshotTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/19.
//

import SnapshotTesting
import XCTest

@testable import TwiterApp

final class LoginViewSnapshotTest: XCTestCase {
    func testScreen() throws {
        let viewModel = LoginViewModel(loginSuccessCallback: {})
        let sut = LoginViewController(viewModel: viewModel)
        
        assertSnapshot(
            matching: sut,
            as: .image(on: .iPhone13ProMax, precision: 0.9))
        
        assertSnapshot(
            matching: sut,
            as: .image(on: .iPhone13, precision: 0.9))
        
        assertSnapshot(
            matching: sut,
            as: .image(on: .iPhoneX, precision: 0.9))
    }
}

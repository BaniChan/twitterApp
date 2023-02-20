//
//  BaseNaviViewSnapshotTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import SnapshotTesting
import Foundation
import XCTest
import Resolver

@testable import TwiterApp

final class BaseNaviViewSnapshotTest: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testScreen() throws {
        let authRepository = AuthRepositoryMock()
        Resolver.test.register { authRepository as AuthRepositoryProtocol }
        Resolver.test.register { PostRepositoryMock() as PostRepositoryProtocol }
        
        let viewModel = BaseNaviViewModel()
        let sut = BaseNaviViewController(viewModel: viewModel)

        assertSnapshot(
            matching: sut,
            as: .image(on: .iPhone13ProMax, precision: 0.9))
        
        assertSnapshot(
            matching: sut,
            as: .image(on: .iPhone13, precision: 0.9))
        
        assertSnapshot(
            matching: sut,
            as: .image(on: .iPhoneX, precision: 0.9))
        
        authRepository.isLoggedIn = true
        viewModel.handleUserLoggedIn()
        
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
    
    private class AuthRepositoryMock: AuthRepositoryProtocol {
        var isLoggedIn = false
        var loggedIn: Bool {
            isLoggedIn
        }
    }
    private class PostRepositoryMock: PostRepositoryProtocol {}
}

//
//  PostViewSnapshotTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/19.
//

import SnapshotTesting
import XCTest
import Resolver
import FirebaseAuth

@testable import TwiterApp

final class PostViewSnapshotTest: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testScreen() throws {
        Resolver.test.register { AuthRepositoryMock() as AuthRepositoryProtocol }
        Resolver.test.register { PostRepositoryMock() as PostRepositoryProtocol }
        
        let viewModel = PostViewModel()
        let sut = PostViewController(viewModel: viewModel)

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
    
    private class AuthRepositoryMock: AuthRepositoryProtocol {}

    private class PostRepositoryMock: PostRepositoryProtocol {}
}

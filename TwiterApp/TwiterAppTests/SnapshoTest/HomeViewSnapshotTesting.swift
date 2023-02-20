//
//  HomeViewSnapshotTesting.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import SnapshotTesting
import XCTest
import Resolver
import FirebaseAuth

@testable import TwiterApp

final class HomeViewSnapshotTesting: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testScreen() throws {
        Resolver.test.register { AuthRepositoryMock() as AuthRepositoryProtocol }
        Resolver.test.register { PostRepositoryMock() as PostRepositoryProtocol }
        let viewModel = HomeViewModel(logoutCallback: {})
        let sut = HomeViewController(viewModel: viewModel)

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

    private class PostRepositoryMock: PostRepositoryProtocol {
        func observeTweet(queryLimited: Int, completion: @escaping ([TwiterApp.Tweet]) -> Void) {
            completion(Tweet.mockTweets)
        }
    }
}

//
//  HomeViewModelTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import XCTest
import Resolver

@testable import TwiterApp

final class HomeViewModelTest: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testLogout() throws {
        let authRepository = AuthRepositoryMock()
        let postRepositoryMock = PostRepositoryMock()
        Resolver.test.register { authRepository as AuthRepositoryProtocol }
        Resolver.test.register { postRepositoryMock as PostRepositoryProtocol }
        
        // click logout button
        var logoutSuccess = false
        let outputMock = HomeViewModelOutputMock()
        let viewModel = HomeViewModel(logoutCallback: { logoutSuccess = true })
        viewModel.viewController = outputMock
        viewModel.clickLogoutButton()
        XCTAssertTrue(outputMock.hasShowLogoutAlert)
        
        // logout
        viewModel.logout()
        XCTAssertTrue(authRepository.logoutSuccess)
        XCTAssertFalse(outputMock.isShowLoading)
        XCTAssertTrue(logoutSuccess)
    }
    
    func testTweetData() throws {
        let authRepository = AuthRepositoryMock()
        let postRepositoryMock = PostRepositoryMock()
        Resolver.test.register { authRepository as AuthRepositoryProtocol }
        Resolver.test.register { postRepositoryMock as PostRepositoryProtocol }
        
        let outputMock = HomeViewModelOutputMock()
        let viewModel = HomeViewModel(logoutCallback: { })
        viewModel.viewController = outputMock
        XCTAssertTrue(viewModel.tweetData.isEmpty)
        
        // load tweet data
        viewModel.reloadTweet()
        XCTAssertFalse(viewModel.tweetData.isEmpty)
        XCTAssertEqual(viewModel.tweetData.count, 4)
        XCTAssertEqual(viewModel.tweetData.count, postRepositoryMock.tweetData.count)
        
        // load more data, after this canLoadMore will be false due to data count < limit number
        viewModel.loadMoreTweet()
        XCTAssertEqual(viewModel.tweetData.count, 7)
        XCTAssertEqual(viewModel.tweetData.count, postRepositoryMock.tweetData.count)
        
        // load more data, will not load
        viewModel.loadMoreTweet()
        XCTAssertEqual(viewModel.tweetData.count, 7)
        XCTAssertEqual(viewModel.tweetData.count, postRepositoryMock.tweetData.count)
        
        // load tweet data
        viewModel.reloadTweet()
        XCTAssertEqual(viewModel.tweetData.count, 4)
        XCTAssertEqual(viewModel.tweetData.count, postRepositoryMock.tweetData.count)
        
        // test canDelete
        XCTAssertTrue(viewModel.canDelete(index: 0))
        XCTAssertFalse(viewModel.canDelete(index: 1))
        
        var dataCount = viewModel.tweetData.count

        // test delete tweet success
        postRepositoryMock.deleteSuccess = true
        viewModel.deleteTweet(by: 1)
        dataCount -= 1
        XCTAssertEqual(viewModel.tweetData.count, dataCount)
        XCTAssertEqual(viewModel.tweetData.count, postRepositoryMock.tweetData.count)
        
        // test delete tweet false
        postRepositoryMock.deleteSuccess = false
        viewModel.deleteTweet(by: 0)
        XCTAssertTrue(outputMock.isShowError)
        XCTAssertEqual(viewModel.tweetData.count, dataCount)
        XCTAssertEqual(viewModel.tweetData.count, postRepositoryMock.tweetData.count)
    }
    
    func testPost() throws {
        let authRepository = AuthRepositoryMock()
        let postRepositoryMock = PostRepositoryMock()
        Resolver.test.register { authRepository as AuthRepositoryProtocol }
        Resolver.test.register { postRepositoryMock as PostRepositoryProtocol }
        
        // click post button
        let outputMock = HomeViewModelOutputMock()
        let viewModel = HomeViewModel(logoutCallback: { })
        viewModel.viewController = outputMock
        viewModel.clickPostButton()
        XCTAssertTrue(outputMock.hasShowPostView)
    }
    
    private class HomeViewModelOutputMock: HomeViewModelOutput {
        var hasShowLogoutAlert = false
        var hasShowPostView = false
        var isShowLoading = false
        var isShowError = false
        
        func showLogoutAlert() {
            hasShowLogoutAlert = true
        }
        
        func showPostView() {
            hasShowPostView = true
        }
        
        func showLoading(_ show: Bool) {
            isShowLoading = show
        }
        
        func showError(_ error: String?) {
            isShowError = true
        }
        
        func reloadTable() {}
        
        func endReloadTable() {}
    }
    
    private class AuthRepositoryMock: AuthRepositoryProtocol {
        var logoutSuccess = false
        
        func logout() throws {
            logoutSuccess = true
        }
    }
    
    private class PostRepositoryMock: PostRepositoryProtocol {
        var tweetData = [Tweet]()
        enum PostRepositoryError: Error {
            case deleteError
        }
        var deleteSuccess = false
        
        func observeTweet(queryLimited: Int, completion: @escaping([Tweet]) -> Void) {
            let tweets = Tweet.mockTweets
            tweetData = tweets
            completion(tweets)
        }
        
        func observeTweetMore(queryLimited: Int, beforeValue: String, completion: @escaping ([Tweet]) -> Void) {
            let tweets = Tweet.mockTweetsMore
            tweetData.append(contentsOf: tweets)
            completion(tweets)
        }
        
        func deleteTweet(_ tweet: Tweet, completion: @escaping (Error?) -> Void) {
            guard deleteSuccess else {
                completion(PostRepositoryError.deleteError)
                return
            }
            if let index = tweetData.firstIndex(where: { $0.key == tweet.key }) {
                tweetData.remove(at: index)
            }
            completion(nil)
        }
    }
}

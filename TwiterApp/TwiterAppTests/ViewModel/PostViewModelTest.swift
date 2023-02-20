//
//  PostViewModelTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import XCTest
import Resolver
import FirebaseAuth

@testable import TwiterApp

final class PostViewModelTest: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testPost() throws {
        let authRepository = AuthRepositoryMock()
        let postRepositoryMock = PostRepositoryMock()
        Resolver.test.register { authRepository as AuthRepositoryProtocol }
        Resolver.test.register { postRepositoryMock as PostRepositoryProtocol }
        
        // click logout button
        let outputMock = PostViewModelOutputMock()
        let viewModel = PostViewModel()
        viewModel.viewController = outputMock
        XCTAssertEqual(viewModel.userDisplayName, authRepository.userName)
        
        // click cancel button
        viewModel.clickCancelButton()
        XCTAssertTrue(outputMock.hasDismiss)
        
        // click image button
        viewModel.clickImageButton()
        XCTAssertTrue(outputMock.hasShowImageSourceSelection)
        
        // click delete image button
        viewModel.selectedImage = UIImage()
        viewModel.scaledImage = viewModel.selectedImage
        outputMock.showImage(true)
        viewModel.clickDeleteImageButton()
        XCTAssertNil(viewModel.selectedImage)
        XCTAssertNil(viewModel.scaledImage)
        XCTAssertFalse(outputMock.isShowImage)
        
        // check canEnablePostButton - no content & no image
        outputMock.contentInput = ""
        viewModel.selectedImage = nil
        viewModel.scaledImage = nil
        XCTAssertFalse(viewModel.canEnablePostButton)
        
        // check canEnablePostButton - no content & has image
        outputMock.contentInput = ""
        viewModel.selectedImage = UIImage()
        viewModel.scaledImage = viewModel.selectedImage
        XCTAssertTrue(viewModel.canEnablePostButton)
        
        // check canEnablePostButton - has content & no image
        outputMock.contentInput = "text"
        viewModel.selectedImage = nil
        viewModel.scaledImage = nil
        XCTAssertTrue(viewModel.canEnablePostButton)
        
        // check canEnablePostButton - has content & has image
        outputMock.contentInput = "text"
        viewModel.selectedImage = UIImage()
        viewModel.scaledImage = viewModel.selectedImage
        XCTAssertTrue(viewModel.canEnablePostButton)
        
        // check click post - failed
        outputMock.hasDismiss = false
        postRepositoryMock.postSuccess = false
        viewModel.clickPostButton()
        XCTAssertFalse(outputMock.isShowLoading)
        XCTAssertTrue(outputMock.isShowError)
        XCTAssertFalse(outputMock.hasDismiss)
        
        // check click post - success
        outputMock.isShowError = false
        postRepositoryMock.postSuccess = true
        viewModel.clickPostButton()
        XCTAssertFalse(outputMock.isShowLoading)
        XCTAssertFalse(outputMock.isShowError)
        XCTAssertTrue(outputMock.hasDismiss)
       
    }
    
    private class PostViewModelOutputMock: PostViewModelOutput {
        var contentInput = ""
        var hasDismiss = false
        var hasShowImageSourceSelection = false
        var isShowImage = false
        var isShowLoading = false
        var isShowError = false
        
        var content: String {
            contentInput
        }
        
        func dismiss() {
            hasDismiss = true
        }
        
        func showImageSourceSelection() {
            hasShowImageSourceSelection = true
        }
        
        func showImage(_ show: Bool) {
            isShowImage = show
        }
        
        func showLoading(_ show: Bool) {
            isShowLoading = show
        }
        
        func showError(_ error: String?) {
            isShowError = true
        }
    }
    
    private class AuthRepositoryMock: AuthRepositoryProtocol {
        let userName = "userName"
        
        var displayName: String? {
            userName
        }
    }
    
    private class PostRepositoryMock: PostRepositoryProtocol {
        enum PostRepositoryError: Error {
            case postError
        }
    
        var postSuccess = true
        
        func postTweet(content: String?, image: UIImage?, scaledImage: UIImage?, completion: @escaping (Error?) -> Void) {
            guard postSuccess else {
                completion(PostRepositoryError.postError)
                return
            }
            completion(nil)
        }
    }
}

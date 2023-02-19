//
//  PostViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit
import Foundation
import Resolver

protocol PostViewModelOutput {
    var content: String { get }
    func dismiss()
    func showImageSourceSelection()
    func showImage(_ show: Bool)
    func showLoading(_ show: Bool)
    func showError(_ error: String?)
}

class PostViewModel {
    typealias ViewController = PostViewModelOutput
    
    @Injected private var postRepository: PostRepositoryProtocol
    @Injected private var authRepository: AuthRepositoryProtocol
    
    private var isLoading = false
    var viewController: ViewController?
    var selectedImage: UIImage?
    var scaledImage: UIImage?
    
    @objc func clickCancelButton() {
        viewController?.dismiss()
    }
    
    @objc func clickPostButton() {
        guard !isLoading else { return }
        showLoading(true)
        postRepository.postTweet(
            content: viewController?.content,
            image: selectedImage,
            scaledImage: scaledImage) { [weak self] error in
                self?.showLoading(false)
                guard error == nil else {
                    self?.viewController?.showError(error?.localizedDescription)
                    return
                }
                self?.viewController?.dismiss()
            }
    }
    
    @objc func clickImageButton() {
        guard !isLoading else { return }
        viewController?.showImageSourceSelection()
    }
    
    @objc func clickDeleteImageButton() {
        guard !isLoading else { return }
        selectedImage = nil
        viewController?.showImage(false)
    }
    
    var canEnablePostButton: Bool {
        !(viewController?.content ?? "").isEmpty || selectedImage != nil
    }
    
    func showLoading(_ show: Bool) {
        isLoading = show
        viewController?.showLoading(show)
    }
    
    var userDisplayName: String {
        authRepository.currentUser?.displayName ?? ""
    }
}

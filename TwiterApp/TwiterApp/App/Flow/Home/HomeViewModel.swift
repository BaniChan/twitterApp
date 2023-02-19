//
//  HomeViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import Foundation
import Resolver

protocol HomeViewModelOutput {
    func showLogoutAlert()
    func showPostView()
    func reloadTable()
    func endReloadTable()
    func showLoading(_ show: Bool)
    func showError(_ error: String?)
}

class HomeViewModel {
    typealias ViewController = HomeViewModelOutput
    
    @Injected private var authRepository: AuthRepositoryProtocol
    @Injected private var postRepository: PostRepositoryProtocol
    
    private static let TweetPagingCount = 20
    var viewController: ViewController?
    private let logoutCallback: () -> Void
    private var hasMoreTweet = true
    private var isLoading = false
    var tweetData = [Tweet]() {
        didSet {
            reloadTable()
        }
    }
    
    init(logoutCallback: @escaping () -> Void) {
        self.logoutCallback = logoutCallback
    }
    
    @objc func reloadTweet() {
        postRepository.observeTweet(queryLimited: Self.TweetPagingCount) { [weak self] tweets in
            guard let self = self else { return }
            self.tweetData = tweets.reversed()
            self.hasMoreTweet = true
        }
    }
    
    func loadMoreTweet() {
        guard hasMoreTweet, let beforeKey = tweetData.last?.key else { return }
        postRepository.observeTweetMore(queryLimited: Self.TweetPagingCount, beforeValue: beforeKey) { [weak self] tweets in
            guard let self = self else { return }
            self.hasMoreTweet = tweets.count == Self.TweetPagingCount
            self.tweetData.append(contentsOf: tweets.reversed())
        }
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.viewController?.reloadTable()
            self.viewController?.endReloadTable()
        }
    }
    
    @objc func clickLogoutButton() {
        guard !isLoading else { return }
        viewController?.showLogoutAlert()
    }
    
    @objc func clickPostButton() {
        guard !isLoading else { return }
        viewController?.showPostView()
    }
    
    func logout() {
        try? authRepository.logout()
        logoutCallback()
    }
    
    func canDelete(index: Int) -> Bool {
        guard let currentUserId = authRepository.currentUser?.uid else { return false }
        return currentUserId == tweetData[index].userId
    }
    
    func deleteTweet(by index: Int) {
        guard !isLoading else { return }
        
        showLoading(true)
        let tweet = tweetData[index]
        postRepository.deleteTweet(tweet) { [weak self] error in
            self?.showLoading(false)
            guard error == nil else {
                self?.viewController?.showError(error?.localizedDescription)
                return
            }
    
            self?.tweetData.remove(at: index)
        }
    }
    
    private func showLoading(_ show: Bool) {
        isLoading = show
        viewController?.showLoading(show)
    }
}

//
//  PostRepository.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import FirebaseAuth
import Resolver
import UIKit

protocol PostRepositoryProtocol {
    func postTweet(content: String?, image: UIImage?, scaledImage: UIImage?, completion: @escaping (Error?) -> Void)
    func observeTweet(queryLimited: Int, completion: @escaping([Tweet]) -> Void)
    func observeTweetMore(queryLimited: Int, beforeValue: String, completion: @escaping ([Tweet]) -> Void)
    func deleteTweet(_ tweet: Tweet, completion: @escaping (Error?) -> Void)
}

class PostRepository: PostRepositoryProtocol {
    @Injected private var authService: AuthServiceProtocol
    @Injected private var dbService: DBServiceProtocol
    @Injected private var storageService: StorageServiceProtocol
    
    func postTweet(content: String?, image: UIImage?, scaledImage: UIImage?, completion: @escaping (Error?) -> Void) {
        guard let image = image else {
            postTweet(content: content, imageURL: nil, scaledImage: nil, completion: completion)
            return
        }
        storageService.uploadImage(image: image) { [weak self] url, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            self?.postTweet(content: content, imageURL: url, scaledImage: scaledImage, completion: completion)
        }
    }
    
    private func postTweet(content: String?, imageURL: URL?, scaledImage: UIImage?, completion: @escaping (Error?) -> Void) {
        guard let user = authService.currentUser() else { return }
        let imageWidth = Double(scaledImage?.size.width ?? 0.0)
        let imageHeight = Double(scaledImage?.size.height ?? 0.0)
        let tweet = Tweet(content: content, imageURL: imageURL, imageWidth: imageWidth, imageHeight: imageHeight, userId: user.uid, userName: user.displayName ?? "")
        dbService.postTweet(tweet, completion: completion)
    }
    
    func observeTweet(queryLimited: Int, completion: @escaping([Tweet]) -> Void) {
        dbService.observeTweet(queryLimited: queryLimited, completion: completion)
    }
    
    func observeTweetMore(queryLimited: Int, beforeValue: String, completion: @escaping ([Tweet]) -> Void) {
        dbService.observeTweetMore(queryLimited: queryLimited, beforeValue: beforeValue, completion: completion)
    }
    
    func deleteTweet(_ tweet: Tweet, completion: @escaping (Error?) -> Void) {
        guard !tweet.imageURL.isEmpty else {
            deleteTweetContent(by: tweet.key, completion: completion)
            return
        }
        deleteTweetPhoto(by: tweet.imageURL) { [weak self] error in
            guard error == nil else {
                completion(error)
                return
            }
            self?.deleteTweetContent(by: tweet.key, completion: completion)
        }
    }
    
    private func deleteTweetPhoto(by url: String, completion: @escaping (Error?) -> Void) {
        storageService.deleteImage(by: url, completion: completion)
    }
    
    private func deleteTweetContent(by key: String, completion: @escaping (Error?) -> Void) {
        dbService.deleteTweet(key: key, completion: completion)
    }
}

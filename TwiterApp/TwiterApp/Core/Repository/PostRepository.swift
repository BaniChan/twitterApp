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
    func postTweet(content: String?, image: UIImage?, completion: @escaping (Error?) -> Void)
}

class PostRepository: PostRepositoryProtocol {
    @Injected private var authService: AuthServiceProtocol
    @Injected private var dbService: DBServiceProtocol
    @Injected private var storageService: StorageServiceProtocol
    
    func postTweet(content: String?, image: UIImage?, completion: @escaping (Error?) -> Void) {
        guard let userId = authService.currentUser()?.uid else { return }
        guard let image = image else {
            postTweet(userId: userId, content: content, imageURL: nil, completion: completion)
            return
        }
        storageService.uploadImage(image: image, userId: userId) { [weak self] url, error in
            guard error == nil else {
                completion(error)
                return
            }
            self?.postTweet(userId: userId, content: content, imageURL: url, completion: completion)
        }
    }
    
    private func postTweet(userId: String, content: String?, imageURL: URL?, completion: @escaping (Error?) -> Void) {
        dbService.postTweet(userId: userId, content: content, imageURL: imageURL, completion: completion)
    }
}

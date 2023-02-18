//
//  PostRepository.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import FirebaseAuth
import Resolver

protocol PostRepositoryProtocol {
    func postTweet(content: String, photo: String, completion: @escaping (Error?) -> Void)
}

class PostRepository: PostRepositoryProtocol {
    @Injected private var authService: AuthServiceProtocol
    @Injected private var dbService: DBServiceProtocol
    
    func postTweet(content: String, photo: String, completion: @escaping (Error?) -> Void) {
        guard let user = authService.currentUser() else { return }
        dbService.postTweet(userId: user.uid, content: content, photo: photo, completion: completion)
    }
}

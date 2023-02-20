//
//  PostRepositoryProtocol+Extension.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import UIKit

@testable import TwiterApp

extension PostRepositoryProtocol {
    func postTweet(content: String?, image: UIImage?, scaledImage: UIImage?, completion: @escaping (Error?) -> Void) {}
    
    func observeTweet(queryLimited: Int, completion: @escaping ([TwiterApp.Tweet]) -> Void) {}
    
    func observeTweetMore(queryLimited: Int, beforeValue: String, completion: @escaping ([TwiterApp.Tweet]) -> Void) {}
    
    func deleteTweet(_ tweet: TwiterApp.Tweet, completion: @escaping (Error?) -> Void) {}
}

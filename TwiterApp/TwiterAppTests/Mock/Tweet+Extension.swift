//
//  Tweet+Extension.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation

@testable import TwiterApp

extension Tweet {
    static var mockTweets: [Tweet] {
        let tweet0 = Tweet(content: "tweet0", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 0", userName: "User 0", timestamp: 0)
        let tweet1 = Tweet(content: "tweet1", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 1", userName: "User 1", timestamp: 0)
        let tweet2 = Tweet(content: "tweet2", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 1", userName: "User 1", timestamp: 0)
        let tweet3 = Tweet(content: "tweet3", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 0", userName: "User 0", timestamp: 0)
        
        return [tweet3, tweet2, tweet1, tweet0]
    }
    
    static var mockTweetsMore: [Tweet] {
        let tweet4 = Tweet(content: "tweet4", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 0", userName: "User 0", timestamp: 0)
        let tweet5 = Tweet(content: "tweet5", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 0", userName: "User 0", timestamp: 0)
        let tweet6 = Tweet(content: "tweet6", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 0", userName: "User 0", timestamp: 0)
        
        return [tweet6, tweet5, tweet4]
    }
}

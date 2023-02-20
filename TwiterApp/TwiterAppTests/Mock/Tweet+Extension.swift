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
        let tweet0 = Tweet(content: "tweet0", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 0", userName: "User 0", timestamp: 1676858852)
        let tweet1 = Tweet(content: "tweet1", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 1", userName: "User 1", timestamp: 1676858752)
        let tweet2 = Tweet(content: "tweet2", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 1", userName: "User 2", timestamp: 1676857652)
        let tweet3 = Tweet(content: "tweet3", imageURL: nil, imageWidth: 0, imageHeight: 0, userId: "user id 0", userName: "User 3", timestamp: 1676658852)
        
        return [tweet0, tweet1, tweet2, tweet3]
    }
}

//
//  Tweet.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/18.
//

import Foundation
import Firebase

struct Tweet {
    var key: String
    let content: String
    var imageURL: String
    var imageWidth: Double
    var imageHeight: Double
    let userId: String
    let userName: String
    let timestamp: Int
    
    init(
        content: String?,
        imageURL: URL?,
        imageWidth: Double,
        imageHeight: Double,
        userId: String,
        userName: String,
        timestamp: Int? = nil
    ) {
        self.key = ""
        self.content = content ?? ""
        self.imageURL = imageURL?.absoluteString ?? ""
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.userId = userId
        self.userName = userName
        self.timestamp = timestamp ?? Int(NSDate().timeIntervalSince1970)
    }
    
    init(_ snapshot: DataSnapshot) {
        let value = snapshot.value as? [String: Any]
        self.key = snapshot.key
        self.content = value?[DBConstant.PostContent] as? String ?? ""
        self.imageURL = value?[DBConstant.PostImage] as? String ?? ""
        self.imageWidth = value?[DBConstant.PostImageWidth] as? Double ?? 0.0
        self.imageHeight = value?[DBConstant.PostImageHeight] as?  Double ?? 0.0
        self.userId = value?[DBConstant.PostUserId] as? String ?? ""
        self.userName = value?[DBConstant.PostUserName] as? String ?? ""
        self.timestamp = value?[DBConstant.PostTimestamp] as? Int ?? 0
    }
    
    var values: [String : Any] {
        [
            DBConstant.PostContent: content,
            DBConstant.PostImage: imageURL,
            DBConstant.PostImageWidth: imageWidth,
            DBConstant.PostImageHeight: imageHeight,
            DBConstant.PostUserId: userId,
            DBConstant.PostUserName: userName,
            DBConstant.PostTimestamp: timestamp
        ]
    }
}

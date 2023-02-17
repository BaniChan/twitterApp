//
//  DBService.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import Firebase

protocol DBServiceProtocol {
    func postTweet(userId: String, content: String, photo: String, completion: @escaping (Error?) -> Void)
}

class DBService: DBServiceProtocol {
    let db: DatabaseReference
    
    init() {
        db = Database.database().reference()
    }
    
    func postTweet(userId: String, content: String, photo: String, completion: @escaping (Error?) -> Void) {
        let values: [String : Any] =
        [
            DBConstant.TweetUser: userId,
            DBConstant.TweetContent: content,
            DBConstant.TweetPhoto: photo,
            DBConstant.TweetTimestamp: Int(NSDate().timeIntervalSince1970)
        ]
        
        db.child(DBConstant.Tweet).childByAutoId().updateChildValues(values) { (error, ref) in
        }
    }
}

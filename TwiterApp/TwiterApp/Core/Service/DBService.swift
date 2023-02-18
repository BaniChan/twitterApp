//
//  DBService.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import Firebase

protocol DBServiceProtocol {
    func postTweet(userId: String, content: String?, imageURL: URL?, completion: @escaping (Error?) -> Void)
}

class DBService: DBServiceProtocol {
    let db: DatabaseReference
    
    init() {
        db = Database.database().reference()
    }
    
    func postTweet(userId: String, content: String?, imageURL: URL?, completion: @escaping (Error?) -> Void) {
        let values: [String : Any] =
        [
            DBConstant.PostUser: userId,
            DBConstant.PostContent: content ?? "",
            DBConstant.PostImage: imageURL?.absoluteString ?? "",
            DBConstant.PostTimestamp: Int(NSDate().timeIntervalSince1970)
        ]
        
        db.child(DBConstant.Post).childByAutoId().updateChildValues(values) { (error, ref) in
            completion(error)
        }
    }
}

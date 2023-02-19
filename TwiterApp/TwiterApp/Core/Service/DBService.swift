//
//  DBService.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import Firebase

protocol DBServiceProtocol {
    func postTweet(_ tweet: Tweet, completion: @escaping (Error?) -> Void)
    func observeTweet(queryLimited: Int, completion: @escaping ([Tweet]) -> Void)
    func observeTweetMore(queryLimited: Int, beforeValue: String, completion: @escaping ([Tweet]) -> Void)
    func deleteTweet(key: String, completion: @escaping (Error?) -> Void)
}

class DBService: DBServiceProtocol {
    private lazy var db = Database.database().reference()
    
    func postTweet(_ tweet: Tweet, completion: @escaping (Error?) -> Void) {
        db.child(DBConstant.Post).childByAutoId().updateChildValues(tweet.values) { (error, ref) in
            completion(error)
        }
    }
    
    func observeTweet(queryLimited: Int, completion: @escaping ([Tweet]) -> Void) {
        db.child(DBConstant.Post).keepSynced(true)
        db.child(DBConstant.Post)
            .queryOrderedByKey()
            .queryLimited(toLast: UInt(queryLimited))
            .observeSingleEvent(of: .value, with: { snapshot in
                var tweets = [Tweet]()
                for case let snapshot as DataSnapshot in snapshot.children {
                    tweets.append(Tweet(snapshot))
                }
                completion(tweets)
            })
    }
    
    func observeTweetMore(queryLimited: Int, beforeValue: String, completion: @escaping ([Tweet]) -> Void) {
        db.child(DBConstant.Post)
            .queryOrderedByKey()
            .queryEnding(beforeValue: beforeValue)
            .queryLimited(toLast: UInt(queryLimited))
            .observeSingleEvent(of: .value, with: { snapshot in
                var tweets = [Tweet]()
                for case let snapshot as DataSnapshot in snapshot.children {
                    tweets.append(Tweet(snapshot))
                }
                completion(tweets)
            })
    }
    
    func deleteTweet(key: String, completion: @escaping (Error?) -> Void) {
        db.child(DBConstant.Post)
            .child(key)
            .removeValue() { error, _ in
                completion(error)
            }
    }
}

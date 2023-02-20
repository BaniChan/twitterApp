//
//  PostRepositoryTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import XCTest
import Resolver

@testable import TwiterApp

final class PostRepositoryTest: XCTestCase {
    override func setUp() {
        Resolver.resetUnitTestRegistrations()
    }
    
    func testObserveTweet() throws {
        let authService = AuthServiceMock()
        let dbService = DBServiceMock()
        let storageServiceMock = StorageServiceMock()
        Resolver.test.register { authService as AuthServiceProtocol }
        Resolver.test.register { dbService as DBServiceProtocol }
        Resolver.test.register { storageServiceMock as StorageServiceProtocol }
        
        // observe tweets
        let postRepository = PostRepository()
        postRepository.observeTweet(queryLimited: 10) { tweets in
            XCTAssertEqual(tweets.count, Tweet.mockTweets.count)
        }
        XCTAssertFalse(dbService.tweetData.isEmpty)
        
        // observe more
        postRepository.observeTweetMore(queryLimited: 10, beforeValue: "") { tweets in
            XCTAssertEqual(tweets.count, Tweet.mockTweetsMore.count)
        }
        XCTAssertFalse(dbService.tweetData.isEmpty)
        XCTAssertEqual(dbService.tweetData.count, Tweet.mockTweets.count + Tweet.mockTweetsMore.count)
    }
    
    func testPostDeleteTweet() throws {
        let authService = AuthServiceMock()
        let dbService = DBServiceMock()
        let storageServiceMock = StorageServiceMock()
        Resolver.test.register { authService as AuthServiceProtocol }
        Resolver.test.register { dbService as DBServiceProtocol }
        Resolver.test.register { storageServiceMock as StorageServiceProtocol }
        
        let postRepository = PostRepository()
        var savedTweetCount = 0
        let image = UIImage()
        
        // post Tweet text only - failed
        dbService.postTweetSuccess = false
        postRepository.postTweet(content: "post 0", image: nil, scaledImage: nil) { error in
            XCTAssertNotNil(error)
        }
        XCTAssertEqual(dbService.tweetData.count, savedTweetCount)
        
        // post Tweet text only - success
        dbService.postTweetSuccess = true
        savedTweetCount += 1
        postRepository.postTweet(content: "post 0", image: nil, scaledImage: nil) { error in
            XCTAssertNil(error)
        }
        XCTAssertEqual(dbService.tweetData.count, savedTweetCount)
        
        // post Tweet image only - failed
        storageServiceMock.uploadImageSuccess = false
        postRepository.postTweet(content: "", image: image, scaledImage: image) { error in
            XCTAssertNotNil(error)
        }
        XCTAssertEqual(dbService.tweetData.count, savedTweetCount)
        
        // post Tweet image only - success
        storageServiceMock.uploadImageSuccess = true
        savedTweetCount += 1
        postRepository.postTweet(content: "", image: image, scaledImage: image) { error in
            XCTAssertNil(error)
        }
        XCTAssertEqual(dbService.tweetData.count, savedTweetCount)
        
        // post Tweet text & image - success
        storageServiceMock.uploadImageSuccess = true
        dbService.postTweetSuccess = true
        savedTweetCount += 1
        postRepository.postTweet(content: "post 0", image: image, scaledImage: image) { error in
            XCTAssertNil(error)
        }
        XCTAssertEqual(dbService.tweetData.count, savedTweetCount)
        XCTAssertNotNil(storageServiceMock.image)
        
        dbService.tweetData = dbService.tweetData.map { tweet in
            var tweet = tweet
            tweet.key = tweet.content
            return tweet
        }
        
        var deleteTweet = dbService.tweetData.last!
        
        // delete Tweet - delete text failed
        dbService.deleteTweetSuccess = false
        postRepository.deleteTweet(deleteTweet) { error in
            XCTAssertNotNil(error)
        }
        XCTAssertEqual(dbService.tweetData.count, savedTweetCount)
        
        // delete Tweet - delete image failed
        dbService.deleteTweetSuccess = true
        storageServiceMock.deleteImageSuccess = false
        savedTweetCount -= 1
        postRepository.deleteTweet(deleteTweet) { error in
            XCTAssertNotNil(error)
        }
        XCTAssertEqual(dbService.tweetData.count, savedTweetCount)
        XCTAssertNotNil(storageServiceMock.image)
        
        // delete Tweet - success
        deleteTweet = dbService.tweetData.last!
        dbService.deleteTweetSuccess = true
        storageServiceMock.deleteImageSuccess = true
        savedTweetCount -= 1
        postRepository.deleteTweet(deleteTweet) { error in
            XCTAssertNil(error)
        }
        XCTAssertEqual(dbService.tweetData.count, savedTweetCount)
        XCTAssertNil(storageServiceMock.image)
    }
    
    private class AuthServiceMock: AuthServiceProtocol {}
    
    private class DBServiceMock: DBServiceProtocol {
        enum DBServiceError: Error {
            case postTweetError
            case deleteTweetError
        }
        
        var image: UIImage? = nil
        var postTweetSuccess = false
        var deleteTweetSuccess = false
        
        var tweetData = [Tweet]()
        
        func observeTweet(queryLimited: Int, completion: @escaping ([Tweet]) -> Void) {
            let data = Tweet.mockTweets
            tweetData = data
            completion(data)
        }
        
        func observeTweetMore(queryLimited: Int, beforeValue: String, completion: @escaping ([Tweet]) -> Void) {
            let data = Tweet.mockTweetsMore
            tweetData.append(contentsOf: data)
            completion(data)
        }
        
        func postTweet(_ tweet: Tweet, completion: @escaping (Error?) -> Void) {
            guard postTweetSuccess else {
                completion(DBServiceError.postTweetError)
                return
            }
            tweetData.append(tweet)
            completion(nil)
        }
        
        func deleteTweet(key: String, completion: @escaping (Error?) -> Void) {
            guard deleteTweetSuccess else {
                completion(DBServiceError.deleteTweetError)
                return
            }
            if let index = tweetData.firstIndex(where: { $0.key == key }) {
                tweetData.remove(at: index)
            }
            completion(nil)
        }
    }
    
    private class StorageServiceMock: StorageServiceProtocol {
        enum StorageServiceError: Error {
            case uploadImageError
            case deleteImageError
        }
        
        var image: UIImage? = nil
        var uploadImageSuccess = false
        var deleteImageSuccess = false
        
        func uploadImage(image: UIImage, completion: @escaping (URL?, Error?) -> Void) {
            guard uploadImageSuccess else {
                completion(nil, StorageServiceError.uploadImageError)
                return
            }
            self.image = image
            completion(URL(string: "http://google.com/abc.jpg"), nil)
        }
        
        func deleteImage(by imageUrl: String, completion: @escaping (Error?) -> Void) {
            guard deleteImageSuccess else {
                completion(StorageServiceError.deleteImageError)
                return
            }
            self.image = nil
            completion(nil)
        }
    }
}

//
//  StringExtensionTest.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import XCTest

@testable import TwiterApp

final class StringExtensionTest: XCTestCase {
    func testIsValidEmail() throws {
        // invalid
        XCTAssertFalse("".isValidEmail)
        XCTAssertFalse("abc".isValidEmail)
        XCTAssertFalse("abc.cc".isValidEmail)
        XCTAssertFalse("abc@aa".isValidEmail)
        XCTAssertFalse("abc@_.cc.cc".isValidEmail)
        
        // valid
        XCTAssertTrue("bani@gmail.com".isValidEmail)
        XCTAssertTrue("bani@aa.cc".isValidEmail)
        XCTAssertTrue("bani@aa.co.jp".isValidEmail)
    }
    
    func testIsValidPassword() throws {
        // invalid
        XCTAssertFalse("".isValidPassword)
        XCTAssertFalse("abc".isValidPassword)
        
        // valid
        XCTAssertTrue("123456".isValidPassword)
        XCTAssertTrue("abcdefghi".isValidPassword)
    }
}

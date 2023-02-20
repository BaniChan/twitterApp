//
//  Resolver+Extension.swift
//  TwiterAppTests
//
//  Created by Bani Chan on 2023/2/20.
//

import Foundation
import Resolver

extension Resolver {
    static var test: Resolver!

    static func resetUnitTestRegistrations() {
        Resolver.test = Resolver(child: .test)
        Resolver.root = .test
    }
}

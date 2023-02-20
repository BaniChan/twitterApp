//
//  Resolver+Injection.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        // don't do injection for testing env
        guard !AppDelegate.inUnitTest else { return }
        
        //repository (scope: application)
        register { PostRepository() as PostRepositoryProtocol }.scope(.application)
        
        //repository (scope: share)
        register { AuthRepository() as AuthRepositoryProtocol }.scope(.shared)
        
        //service
        register { AuthService() as AuthServiceProtocol }.scope(.shared)
        register { DBService() as DBServiceProtocol }.scope(.shared)
        register { StorageService() as StorageServiceProtocol }.scope(.shared)
    }
}

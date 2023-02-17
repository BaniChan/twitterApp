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
        //repository (scope: application)
        register { DBRepository() as DBRepositoryProtocol }.scope(.application)
        
        //repository (scope: share)
        register { AuthRepository() as AuthRepositoryProtocol }.scope(.shared)
        
        //service
        register { AuthService() as AuthServiceProtocol }.scope(.shared)
        register { DBService() as DBServiceProtocol }.scope(.shared)
    }
}

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
        //view model
        

        //repositories

        
        //services
        register { FirebaseAuthService() as FirebaseAuthServiceProtocol }.scope(.shared)
    }
}

//
//  HomeViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import Foundation
import Resolver

protocol HomeViewModelOutput {
    func showLogoutAlert()
    func showPostView()
}

class HomeViewModel {
    typealias ViewController = HomeViewModelOutput
    
    @Injected private var authRepository: AuthRepositoryProtocol
    
    var viewController: ViewController?
    private let logoutCallback: () -> Void
    
    init(logoutCallback: @escaping () -> Void) {
        self.logoutCallback = logoutCallback
    }
    
    @objc func clickAccountButton() {
        viewController?.showLogoutAlert()
    }
    
    @objc func clickPostButton() {
        viewController?.showPostView()
    }
    
    func logout() {
        try? authRepository.signOut()
        logoutCallback()
    }
}

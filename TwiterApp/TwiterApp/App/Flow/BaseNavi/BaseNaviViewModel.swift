//
//  BaseNaviViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import Foundation
import Resolver

protocol BaseNaviViewModelOutput {
    func showWelcomeView(loginSuccessCallback: @escaping () -> Void)
    func showHomeView(logoutCallback: @escaping () -> Void)
}

class BaseNaviViewModel {
    typealias ViewController = BaseNaviViewModelOutput
    
    @Injected private var authRepository: AuthRepositoryProtocol
    
    var viewController: ViewController?
    
    func handleUserLoggedIn() {
        guard !authRepository.loggedIn
        else {
            showHomeView()
            return
        }
        showWelcomeView()
    }
    
    private func showHomeView() {
        viewController?.showHomeView() { [weak self] in
            self?.showWelcomeView()
        }
    }
    
    private func showWelcomeView() {
        viewController?.showWelcomeView() { [weak self] in
            self?.showHomeView()
        }
    }
}

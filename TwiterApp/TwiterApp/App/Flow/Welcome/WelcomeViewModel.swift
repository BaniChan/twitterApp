//
//  WelcomeViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import Foundation
import Resolver

protocol WelcomeViewModelOutput {
    func showCreateAccountView(createSuccessCallback: @escaping () -> Void)
    func showLoginView(loginSuccessCallback: @escaping () -> Void)
}

class WelcomeViewModel {
    typealias ViewController = WelcomeViewModelOutput
    private let loginSuccessCallback: () -> Void
    
    init(loginSuccessCallback: @escaping () -> Void) {
        self.loginSuccessCallback = loginSuccessCallback
    }
    
    var viewController: ViewController?
    
    @objc func clickCreateAccountButton() {
        viewController?.showCreateAccountView() { [weak self] in
            self?.showLoginView()
        }
    }
    
    @objc func clickLoginButton() {
        showLoginView()
    }
    
    private func showLoginView() {
        viewController?.showLoginView(loginSuccessCallback: loginSuccessCallback)
    }
}


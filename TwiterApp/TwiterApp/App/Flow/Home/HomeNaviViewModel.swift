//
//  HomeNaviViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit
import Foundation
import Resolver

protocol HomeNaviViewModelDelegate: UINavigationController {

}

class HomeNaviViewModel {
    @Injected private var authRepository: AuthRepositoryProtocol
    var viewController: HomeNaviViewModelDelegate? = nil
    
    func handleUserLoggedIn() {
        guard !authRepository.loggedIn else { return }
        showLoginView()
    }
    
    private func showLoginView() {
        let loginVC = LoginController()
        viewController?.setViewControllers([loginVC], animated: true)
    }
}

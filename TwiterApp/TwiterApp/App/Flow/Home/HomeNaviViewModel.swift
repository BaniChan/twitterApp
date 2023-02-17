//
//  HomeNaviViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit
import Foundation
import Resolver

protocol HomeNaviViewModelOutput: UINavigationController {

}

class HomeNaviViewModel {
    typealias ViewController = HomeNaviViewModelOutput
    
    @Injected private var authRepository: AuthRepositoryProtocol
    
    weak var viewController: ViewController?
    
    func handleUserLoggedIn() {
        guard !authRepository.loggedIn else { return }
        showLoginView()
    }
    
    private func showLoginView() {
        let viewModel = WelcomeViewModel() {
            print("login success")
        }
        let loginVC = WelcomeViewController(viewModel: viewModel)
        viewController?.setViewControllers([loginVC], animated: true)
    }
}

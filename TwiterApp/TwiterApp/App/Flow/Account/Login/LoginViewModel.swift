//
//  LoginViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit
import Foundation
import Resolver

protocol LoginViewModelOutput: UIViewController {
}

class LoginViewModel {
    typealias ViewController = LoginViewModelOutput
    
    @Injected private var authRepository: AuthRepositoryProtocol
    
    weak var viewController: ViewController?
    
    @objc func goCreateAccount() {
        let createAccountViewController = CreateAccountViewController()
        self.viewController?.navigationController?.pushViewController(createAccountViewController, animated: true)
    }
}


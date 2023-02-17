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
    var email: String? { get }
    var password: String? { get }
    func showError(_ error: String?)
    func enableLoginButton(_ enable: Bool)
    func loginSuccess()
    func showLoading(_ show: Bool)
}

class LoginViewModel {
    enum LoginError: LocalizedError {
        case emailFormatInvalid
        case passwordLengthInvalid
        
        var errorDescription: String? {
            switch self {
            case .emailFormatInvalid: return "Please input valid email"
            case .passwordLengthInvalid: return "Password's length shoud be more than 6"
            }
        }
    }
    
    typealias ViewController = LoginViewModelOutput
    
    @Injected private var authRepository: AuthRepositoryProtocol
    
    weak var viewController: ViewController?
    
    @objc func textFieldEditingChanged() {
        viewController?.showError(nil)
        
        guard let email = viewController?.email,
              let password = viewController?.password else { return }
        
        guard !email.isEmpty, !password.isEmpty
        else {
            viewController?.enableLoginButton(false)
            return
        }
        
        var error: LoginError?
        if !email.isValidEmail {
            error = .emailFormatInvalid
        }
        
        if !password.isValidPassword {
            error = .passwordLengthInvalid
        }
        
        viewController?.showError(error?.errorDescription)
        viewController?.enableLoginButton(error == nil)
    }
    
    @objc func clickSignUpButton() {
        let createAccountViewController = CreateAccountViewController(viewModel: CreateAccountViewModel())
        self.viewController?.navigationController?.pushViewController(createAccountViewController, animated: true)
    }
    
    @objc func clickLoginButton() {
        guard let email = viewController?.email,
              let password = viewController?.password else { return }
        viewController?.showLoading(true)
        authRepository.signIn(email: email, password: password) { [weak self] result, error in
            self?.viewController?.showLoading(false)
            guard result != nil else {
                self?.viewController?.showError(error?.localizedDescription)
                return
            }
            self?.viewController?.loginSuccess()
        }
    }
}


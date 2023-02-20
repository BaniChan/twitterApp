//
//  LoginViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import Foundation
import Resolver

protocol LoginViewModelOutput {
    var email: String? { get }
    var password: String? { get }
    func showError(_ error: String?)
    func enableLoginButton(_ enable: Bool)
    func showLoading(_ show: Bool)
}

class LoginViewModel {
    enum LoginError: LocalizedError {
        case emailFormatInvalid
        case passwordLengthInvalid
        
        var errorDescription: String? {
            switch self {
            case .emailFormatInvalid: return R.string.localizable.pleaseInputValidEmail()
            case .passwordLengthInvalid: return R.string.localizable.passwordSLengthShoudBeMoreThan6()
            }
        }
    }
    
    typealias ViewController = LoginViewModelOutput
    
    @LazyInjected private var authRepository: AuthRepositoryProtocol
    
    var viewController: ViewController?
    private let loginSuccessCallback: () -> Void
    private var isLoading = false
    
    init(loginSuccessCallback: @escaping () -> Void) {
        self.loginSuccessCallback = loginSuccessCallback
    }
    
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
    
    @objc func clickLoginButton() {
        guard !isLoading else { return }
        guard let email = viewController?.email,
              let password = viewController?.password else { return }
        viewController?.showLoading(true)
        authRepository.login(email: email, password: password) { [weak self] success, error in
            self?.viewController?.showLoading(false)
            guard success else {
                self?.viewController?.showError(error?.localizedDescription)
                return
            }
            self?.loginSuccessCallback()
        }
    }
    
    private func showLoading(_ show: Bool) {
        isLoading = show
        viewController?.showLoading(show)
    }
}

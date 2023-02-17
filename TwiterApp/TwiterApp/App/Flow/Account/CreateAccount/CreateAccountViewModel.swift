//
//  CreateAccountViewModel.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import Foundation
import Resolver

protocol CreateAccountViewModelOutput {
    var name: String? { get }
    var email: String? { get }
    var password: String? { get }
    var confirmPassword: String? { get }
    func showError(_ error: String?)
    func enableCreateButton(_ enable: Bool)
    func dismiss()
    func showLoading(_ show: Bool)
}

class CreateAccountViewModel {
    enum CreateAccountError: LocalizedError {
        case emailFormatInvalid
        case passwordLengthInvalid
        case passwordNotMatch
        
        var errorDescription: String? {
            switch self {
            case .emailFormatInvalid: return "Please input valid email"
            case .passwordLengthInvalid: return "Password's length shoud be more than 6"
            case .passwordNotMatch: return "Passwords do not matched"
            }
        }
    }
    
    typealias ViewController = CreateAccountViewModelOutput
    
    @Injected private var authRepository: AuthRepositoryProtocol
    
    var viewController: ViewController?
    
    @objc func textFieldEditingChanged() {
        viewController?.showError(nil)
        
        guard let name = viewController?.name,
              let email = viewController?.email,
              let password = viewController?.password,
              let confirmPassword = viewController?.confirmPassword else { return }
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty
        else {
            viewController?.enableCreateButton(false)
            return
        }
        
        var error: CreateAccountError?
        if !email.isValidEmail {
            error = .emailFormatInvalid
        }
        
        if !password.isValidPassword {
            error = .passwordLengthInvalid
        }
        
        if password != confirmPassword {
            error = .passwordNotMatch
        }
        
        viewController?.showError(error?.errorDescription)
        viewController?.enableCreateButton(error == nil)
    }
    
    @objc func clickCreateButton() {
        guard let name = viewController?.name,
              let email = viewController?.email,
              let password = viewController?.password else { return }
        viewController?.showLoading(true)
        authRepository.createUser(
            displayName: name,
            email: email,
            password: password) { [weak self] result, error in
                self?.viewController?.showLoading(false)
                guard result != nil else {
                    self?.viewController?.showError(error?.localizedDescription)
                    return
                }
                self?.viewController?.dismiss()
        }
    }
}


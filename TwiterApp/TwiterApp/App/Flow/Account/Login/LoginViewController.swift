//
//  LoginViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

class LoginViewController: UIViewController {
    typealias ViewModel = LoginViewModel
    
    private let viewModel: ViewModel
    private let topIcon = CustonImageView.smaillIcon
    private let mainTitle = CustomLabel.mainTitle(R.string.localizable.loginWithYourAccount())
    private let emailTextField = CustomTextField.email
    private let passwordTextField = CustomTextField.password
    private let errorLabel = CustomLabel.error
    private let loginButton = CustomButton.defaultButton(R.string.localizable.logIn())
    private let loadingIndicator = CustomIndicatorView.loadingIndicator
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let inputFieldVPadding: CGFloat = 30
    
    private lazy var emailContainer: UIStackView = {
        let container = UIStackView(arrangedSubviews: [CustomLabel.inputFieldTitle(R.string.localizable.emailAddress()), emailTextField, CustomView.separator])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .fillProportionally
        return container
    }()
    
    private lazy var passwordContainer: UIStackView = {
        let container = UIStackView(arrangedSubviews: [CustomLabel.inputFieldTitle(R.string.localizable.password()), passwordTextField, CustomView.separator])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .fillProportionally
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = R.color.background()

        view.addSubview(topIcon)
        NSLayoutConstraint.activate([
            topIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            topIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(mainTitle)
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: topIcon.bottomAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(emailContainer)
        NSLayoutConstraint.activate([
            emailContainer.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: inputFieldVPadding),
            emailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            emailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        emailTextField.delegate = self
        emailTextField.addTarget(viewModel, action: #selector(viewModel.textFieldEditingChanged), for: .editingChanged)
        
        view.addSubview(passwordContainer)
        NSLayoutConstraint.activate([
            passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: inputFieldVPadding),
            passwordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            passwordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        passwordTextField.delegate = self
        passwordTextField.addTarget(viewModel, action: #selector(viewModel.textFieldEditingChanged), for: .editingChanged)
        
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: inputFieldVPadding),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        loginButton.addTarget(viewModel, action: #selector(viewModel.clickLoginButton), for: .touchUpInside)
        
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController: LoginViewModelOutput {
    var email: String? {
        emailTextField.text
    }
    
    var password: String? {
        passwordTextField.text
    }
    
    func showError(_ error: String?) {
        errorLabel.text = error ?? ""
    }
    
    func enableLoginButton(_ enable: Bool) {
        loginButton.isEnabled = enable
        loginButton.backgroundColor = enable ? CustomButton.enableBackgroundColor: CustomButton.disableBackgroundColor
    }
    
    func showLoading(_ show: Bool) {
        if show {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

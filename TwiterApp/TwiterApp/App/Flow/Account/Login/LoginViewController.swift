//
//  LoginViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

class LoginController: UIViewController {
    typealias ViewModel = LoginViewModel
    typealias LoginSuccessCallback = () -> Void
    
    private let viewModel: ViewModel
    private let topIcon = CustonImageView.smaillIcon
    private let mainTitle = CustomLabel.mainTitle("Login with your account")
    private let emailTextField = CustomTextField.email
    private let passwordTextField = CustomTextField.password
    private let errorLabel = CustomLabel.error
    private let loginButton = CustomButton.defaultButton("LOGIN")
    private let loadingIndicator = CustomIndicatorView.loadingIndicator
    private let loginSuccessCallback: LoginSuccessCallback
    
    init(viewModel: ViewModel, loginSuccessCallback: @escaping LoginSuccessCallback) {
        self.viewModel = viewModel
        self.loginSuccessCallback = loginSuccessCallback
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let inputFieldVPadding: CGFloat = 30
    
    private lazy var emailContainer: UIStackView = {
       let container = UIStackView(arrangedSubviews: [CustomLabel.inputFieldTitle("Email address"), emailTextField, CustomView.separator])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .fillProportionally
        return container
    }()
    
    private lazy var passwordContainer: UIStackView = {
       let container = UIStackView(arrangedSubviews: [CustomLabel.inputFieldTitle("Password"), passwordTextField, CustomView.separator])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .fillProportionally
        return container
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "MainTitle")
        label.text = "Don't have account?"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(named: "SignUpLinkText"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private lazy var signUpContainer: UIStackView = {
       let container = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .horizontal
        container.spacing = 8
        container.distribution = .fillProportionally
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "Background")

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
        
        view.addSubview(signUpContainer)
        NSLayoutConstraint.activate([
            signUpContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            signUpContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing)
        ])
        signUpButton.addTarget(viewModel, action: #selector(viewModel.clickSignUpButton), for: .touchUpInside)
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: signUpContainer.topAnchor, constant: -15),
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

extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginController: LoginViewModelOutput {
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
    
    func loginSuccess() {
        loginSuccessCallback()
    }
    
    func showLoading(_ show: Bool) {
        if show {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

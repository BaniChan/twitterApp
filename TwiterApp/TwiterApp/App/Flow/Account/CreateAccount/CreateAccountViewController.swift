//
//  CreateAccountViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

class CreateAccountViewController: UIViewController {
    typealias ViewModel = CreateAccountViewModel
    
    private let viewModel: ViewModel
    private let topIcon = CustomImageView.smallIcon
    private let mainTitle = CustomLabel.mainTitle(R.string.localizable.createYourAccount())
    private let nameTextField = CustomTextField.name
    private let emailTextField = CustomTextField.email
    private let passwordTextField = CustomTextField.password
    private let confirmPasswordTextField = CustomTextField.confirmPassword
    private let errorLabel = CustomLabel.error
    private let createButton = CustomButton.defaultButton(R.string.localizable.create())
    private let loadingIndicator = CustomIndicatorView.loadingIndicator
    
    private let inputFieldVPadding: CGFloat = 30
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var nameContainer: UIStackView = {
        let container = UIStackView(arrangedSubviews: [CustomLabel.inputFieldTitle(R.string.localizable.name()), nameTextField, CustomView.separator])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .fillProportionally
        return container
    }()
    
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
    
    private lazy var confirmPasswordContainer: UIStackView = {
        let container = UIStackView(arrangedSubviews: [CustomLabel.inputFieldTitle(R.string.localizable.confirmPassword()), confirmPasswordTextField, CustomView.separator])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
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
        
        view.addSubview(nameContainer)
        NSLayoutConstraint.activate([
            nameContainer.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: inputFieldVPadding),
            nameContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            nameContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        nameTextField.delegate = self
        nameTextField.addTarget(viewModel, action: #selector(viewModel.textFieldEditingChanged), for: .editingChanged)
        
        view.addSubview(emailContainer)
        NSLayoutConstraint.activate([
            emailContainer.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: inputFieldVPadding),
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
        passwordTextField.addTarget(viewModel, action: #selector(viewModel.textFieldEditingChanged), for: .editingDidEnd)
        
        view.addSubview(confirmPasswordContainer)
        NSLayoutConstraint.activate([
            confirmPasswordContainer.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: inputFieldVPadding),
            confirmPasswordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            confirmPasswordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.addTarget(viewModel, action: #selector(viewModel.textFieldEditingChanged), for: .editingChanged)
        
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: confirmPasswordContainer.bottomAnchor, constant: inputFieldVPadding),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        createButton.addTarget(viewModel, action: #selector(viewModel.clickCreateButton), for: .touchUpInside)
        
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateAccountViewController: CreateAccountViewModelOutput {
    var name: String? {
        nameTextField.text
    }
    
    var email: String? {
        emailTextField.text
    }
    
    var password: String? {
        passwordTextField.text
    }
    
    var confirmPassword: String? {
        confirmPasswordTextField.text
    }
    
    func showError(_ error: String?) {
        errorLabel.text = error ?? ""
    }
    
    func enableCreateButton(_ enable: Bool) {
        createButton.isEnabled = enable
        createButton.backgroundColor = enable ? CustomButton.enableBackgroundColor: CustomButton.disableBackgroundColor
    }
    
    func showLoading(_ show: Bool) {
        if show {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

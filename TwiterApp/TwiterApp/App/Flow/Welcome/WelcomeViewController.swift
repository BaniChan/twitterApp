//
//  WelcomeViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit

class WelcomeViewController: UIViewController {
    typealias ViewModel = WelcomeViewModel
    typealias LoginSuccessCallback = () -> Void
    
    private let viewModel: ViewModel
    private let topIcon = CustomImageView.smallIcon
    private let mainTitle = CustomLabel.welcomTitle
    private let createAccountButton = CustomButton.defaultButton(R.string.localizable.createAccount(), enable: true)
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private let loginUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainTitle()
        label.text = R.string.localizable.haveAccountAlready()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(R.string.localizable.logIn(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(R.color.signUpLinkText(), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private lazy var loginContainer: UIStackView = {
       let container = UIStackView(arrangedSubviews: [loginUpLabel, loginButton])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .horizontal
        container.spacing = 8
        container.distribution = .fillProportionally
        return container
    }()
    
    func setupUI() {
        view.backgroundColor = R.color.background()

        view.addSubview(topIcon)
        NSLayoutConstraint.activate([
            topIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            topIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(mainTitle)
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: topIcon.bottomAnchor, constant: 50),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(loginContainer)
        NSLayoutConstraint.activate([
            loginContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            loginContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing)
        ])
        loginButton.addTarget(viewModel, action: #selector(viewModel.clickLoginButton), for: .touchUpInside)
        
        view.addSubview(createAccountButton)
        NSLayoutConstraint.activate([
            createAccountButton.bottomAnchor.constraint(equalTo: loginContainer.topAnchor, constant: -15),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        createAccountButton.isEnabled = true
        createAccountButton.addTarget(viewModel, action: #selector(viewModel.clickCreateAccountButton), for: .touchUpInside)
    }
}

extension WelcomeViewController: WelcomeViewModelOutput {
    func showCreateAccountView(createSuccessCallback: @escaping () -> Void) {
        let viewModel = CreateAccountViewModel(createSuccessCallback: createSuccessCallback)
        let viewController = CreateAccountViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showLoginView(loginSuccessCallback: @escaping () -> Void) {
        let viewModel = LoginViewModel(loginSuccessCallback: loginSuccessCallback)
        let viewController = LoginViewController(viewModel: viewModel)
        guard var viewControllers = navigationController?.viewControllers,
              let lastVC = viewControllers.last,
              type(of: lastVC) == CreateAccountViewController.self else {
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
        viewControllers.removeLast()
        viewControllers.append(viewController)
        navigationController?.setViewControllers(viewControllers, animated: true)
    }
}

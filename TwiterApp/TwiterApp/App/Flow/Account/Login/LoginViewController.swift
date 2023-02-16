//
//  LoginViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

class LoginController: UIViewController {
    private let mainTitle = UILabel.mainTitle("Login with your account")
    private let emailTextField = UITextField.email
    private let passwordTextField = UITextField.password
    private let loginButton = UIButton.defaultButton("LOGIN")
    
    private let inputFieldVPadding: CGFloat = 30
    
    private lazy var emailContainer: UIStackView = {
       let container = UIStackView(arrangedSubviews: [UILabel.inputFieldTitle("Email address"), emailTextField, UIView.separator])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .fillProportionally
        return container
    }()
    
    private lazy var passwordContainer: UIStackView = {
       let container = UIStackView(arrangedSubviews: [UILabel.inputFieldTitle("Password"), passwordTextField, UIView.separator])
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
        
        view.addSubview(mainTitle)
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(emailContainer)
        NSLayoutConstraint.activate([
            emailContainer.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: inputFieldVPadding),
            emailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            emailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(passwordContainer)
        NSLayoutConstraint.activate([
            passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: inputFieldVPadding),
            passwordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            passwordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(signUpContainer)
        NSLayoutConstraint.activate([
            signUpContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            signUpContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: signUpContainer.topAnchor, constant: -15),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
    }
}


//
//  CreateAccountController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/16.
//

import UIKit

class CreateAccountController: UIViewController {
    private let mainTitle = UILabel.mainTitle("Create your account")
    private let nameTextField = UITextField.name
    private let emailTextField = UITextField.email
    private let passwordTextField = UITextField.password
    private let confirmPasswordTextField = UITextField.confirmPassword
    private let createButton = UIButton.defaultButton("CREATE")
    
    private let inputFieldVPadding: CGFloat = 30
    
    private lazy var nameContainer: UIStackView = {
       let container = UIStackView(arrangedSubviews: [UILabel.inputFieldTitle("Name"), nameTextField, UIView.separator])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 0
        container.distribution = .fillProportionally
        return container
    }()
    
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
    
    private lazy var confirmPasswordContainer: UIStackView = {
       let container = UIStackView(arrangedSubviews: [UILabel.inputFieldTitle("Confirm password"), confirmPasswordTextField, UIView.separator])
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
        view.backgroundColor = UIColor(named: "Background")
        
        view.addSubview(mainTitle)
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(nameContainer)
        NSLayoutConstraint.activate([
            nameContainer.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: inputFieldVPadding),
            nameContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            nameContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(emailContainer)
        NSLayoutConstraint.activate([
            emailContainer.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: inputFieldVPadding),
            emailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            emailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(passwordContainer)
        NSLayoutConstraint.activate([
            passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: inputFieldVPadding),
            passwordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            passwordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(confirmPasswordContainer)
        NSLayoutConstraint.activate([
            confirmPasswordContainer.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: inputFieldVPadding),
            confirmPasswordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            confirmPasswordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
        
        view.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.edgeSpacing),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeSpacing)
        ])
    }
}


//
//  HomeViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit
import FirebaseAuth
import Resolver

class HomeViewController: UIViewController {
    typealias ViewModel = HomeViewModel
    
    private let viewModel: ViewModel
    private let topIcon = CustomImageView.smallIcon
    private let accountButton = CustomButton.accountButton
    
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
    
    func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = R.color.background()
        
        view.addSubview(topIcon)
        NSLayoutConstraint.activate([
            topIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            topIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(accountButton)
        NSLayoutConstraint.activate([
            accountButton.centerYAnchor.constraint(equalTo: topIcon.centerYAnchor),
            accountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        accountButton.addTarget(viewModel, action: #selector(viewModel.clickAccountButton), for: .touchUpInside)
    }
}

extension HomeViewController: HomeViewModelOutput {
    func showLogoutAlert() {
        let alert = UIAlertController(
            title: R.string.localizable.logout(),
            message: R.string.localizable.areYouSureYouWantToLogout(),
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.confirm(), style: UIAlertAction.Style.default) { [weak self] action in
            self?.viewModel.logout()
        })
        alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

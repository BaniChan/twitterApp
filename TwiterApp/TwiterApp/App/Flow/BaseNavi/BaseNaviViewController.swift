//
//  BaseNaviViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/15.
//

import UIKit
import FirebaseAuth
import Resolver

class BaseNaviViewController: UINavigationController {
    typealias ViewModel = BaseNaviViewModel
    private let viewModel: ViewModel
    
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.handleUserLoggedIn()
    }
    
    func setupUI() {
        setNavigationBarHidden(true, animated: false)
        view.backgroundColor = R.color.background()
        navigationBar.tintColor = R.color.buttonBackground()

    }
}

extension BaseNaviViewController: BaseNaviViewModelOutput {
    func showWelcomeView(loginSuccessCallback: @escaping () -> Void) {
        let viewModel = WelcomeViewModel(loginSuccessCallback: loginSuccessCallback)
        let loginVC = WelcomeViewController(viewModel: viewModel)
        setViewControllers([loginVC], animated: true)
    }
    
    func showHomeView(logoutCallback: @escaping () -> Void) {
        let viewModel = HomeViewModel(logoutCallback: logoutCallback)
        let homeVC = HomeViewController(viewModel: viewModel)
        setViewControllers([homeVC], animated: true)
    }
}

//
//  HomeNaviViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/15.
//

import UIKit
import FirebaseAuth
import Resolver

class HomeNaviViewController: UINavigationController {
    typealias ViewModel = HomeNaviViewModel
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
        view.backgroundColor = UIColor(named: "Background")
        navigationBar.tintColor = UIColor(named: "ButtonBackground")

    }
}

extension HomeNaviViewController: HomeNaviViewModelOutput {
    
}

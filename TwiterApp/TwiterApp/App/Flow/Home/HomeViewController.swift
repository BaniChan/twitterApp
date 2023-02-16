//
//  HomeViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/15.
//

import UIKit
import FirebaseAuth
import Resolver

class HomeViewController: UINavigationController, HomeViewModelDelegate {
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewController = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.handleUserLoggedIn()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "Background")
    }
}

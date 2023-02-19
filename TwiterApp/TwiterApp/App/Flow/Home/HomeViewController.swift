//
//  HomeViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/17.
//

import UIKit

class HomeViewController: UIViewController {
    typealias ViewModel = HomeViewModel
    
    private let viewModel: ViewModel
    private lazy var topIcon = CustomImageView.smallIcon
    private lazy var logoutButton = CustomButton.logoutButton
    private lazy var addPostButton = CustomButton.addPostButton
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let refreshControl = UIRefreshControl()
    private lazy var topSeparator = CustomView.separator
    
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
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadTweet()
    }
    
    func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = R.color.background()
        
        view.addSubview(topIcon)
        NSLayoutConstraint.activate([
            topIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            topIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.centerYAnchor.constraint(equalTo: topIcon.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        logoutButton.addTarget(viewModel, action: #selector(viewModel.clickLogoutButton), for: .touchUpInside)
        
        view.addSubview(topSeparator)
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topIcon.bottomAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topSeparator.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        refreshControl.addTarget(viewModel, action: #selector(viewModel.reloadTweet), for: .valueChanged)
        
        view.addSubview(addPostButton)
        NSLayoutConstraint.activate([
            addPostButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            addPostButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        addPostButton.addTarget(viewModel, action: #selector(viewModel.clickPostButton), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TweetCell.self, forCellReuseIdentifier: TweetCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
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
    
    func showPostView() {
        let viewModel = PostViewModel()
        let viewController = PostViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func endReloadTable() {
        refreshControl.endRefreshing()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    // for load more could try UITableViewDataSourcePrefetching
    // could use diffable datasource for mutating timeline data
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tweetData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.identifier, for: indexPath) as! TweetCell
        cell.setData(tweet: viewModel.tweetData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == viewModel.tweetData.count - 1 else { return }
        viewModel.loadMoreTweet()
    }
}

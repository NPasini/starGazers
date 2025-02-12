//
//  StarGazersListViewController.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

import UIKit

class StarGazersListViewController: UIViewController {
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!
    
    private let messageViewHeight: CGFloat = 40
    private let animationDuration: TimeInterval = 0.3
    
    private let presenter: StarGazersListPresenterProtocol
    
    private var starGazers: [StarGazer] = []
    
    //    private var isNetworkConnectionAvailable: Bool = true
//    private(set) var compositeDisposable = CompositeDisposable()
    //    private var networkMonitorService: NetworkMonitorService? = AssemblerWrapper.shared.resolve(NetworkMonitorService.self)
    
//    private let viewModel: StarGazersListViewModelProtocol
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
        messageViewHeightConstraint.constant = 0
        setTitle(presenter.title, color: UIColor.frontOrange)
        
//        compositeDisposable += networkMonitorService?.isNetworkAvailable.producer.startWithValues({ [weak self] (isAvailable: Bool?) in
//            if let connectionAvailable = isAvailable {
//                self?.isNetworkConnectionAvailable = connectionAvailable
//                if !connectionAvailable {
//                    self?.showMessageView(message: "Network not available")
//                } else {
//                    self?.hideMessageView()
//                }
//            }
//        })
        
//        compositeDisposable += gazersViewModel.errorSignal.producer.filter({ $0 == true }).observe(on: UIScheduler()).on(value: { [weak self] _ in
//            self?.showAlert(title: "Error", message: self?.viewModel.errorMessage() ?? "")
//        }).start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
//        gazersViewModel.getStarGazers()
    }
    
    // MARK: Initializers
    
    init?(coder: NSCoder, presenter: StarGazersListPresenterProtocol) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StarGazersListViewController: StarGazersListViewProtocol {
    func displayData(_ starGazers: [StarGazer]) {
        self.starGazers = starGazers
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: Private Methods

private extension StarGazersListViewController{
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self

        let spinnerView = UIActivityIndicatorView(style: .large)
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))

        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.startAnimating()
        footerView.addSubview(spinnerView)

        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])

        tableView.rowHeight = 80
        tableView.backgroundColor = .clear
        tableView.tableFooterView = footerView
        tableView.register(viewType: StarGazerTableViewCell.self)

//        compositeDisposable += tableView.reactive.reloadData <~ gazersViewModel.gazersDataSource.signal.map({ [weak self] (gazers: [Gazer]) in
//            OSLogger.uiLog(message: "Reloading TableView", access: .public, type: .debug)
//            if gazers.count == 0, let isConnectionAvailable = self?.isNetworkConnectionAvailable, isConnectionAvailable {
//                DispatchQueue.main.async {
//                    self?.showAlert(title: "No Gazers", message: "There are no gazers for this repository")
//                }
//            }
//        })

//        compositeDisposable += spinnerView.reactive.isAnimating <~ gazersViewModel.stopFetchingData.producer.map({ [weak self] (stopFetching: Bool) -> Bool in
//            OSLogger.uiLog(message: "Spinner view is spinning: \(!stopFetching)", access: .public, type: .debug)
//
//            DispatchQueue.main.async {
//                if stopFetching {
//                    self?.tableView.tableFooterView = UIView(frame: .zero)
//                } else {
//                    self?.tableView.tableFooterView = footerView
//                }
//            }
//
//            return !stopFetching
//        })
    }

    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        customizeNavigationBar(backgroundColor: UIColor.backGrey, backButtonColor: UIColor.lightText)
    }

    func showMessageView(message: String) {
//        DispatchQueue.main.async {
//            self.messageLabel.text = message
//            self.messageViewHeightConstraint.constant = self.messageViewHeight
//
//            UIView.animate(withDuration: self.animationDuration) {
//                self.view.layoutIfNeeded()
//            }
//        }
    }

    func hideMessageView() {
//        DispatchQueue.main.async {
//            self.messageViewHeightConstraint.constant = 0
//
//            UIView.animate(withDuration: self.animationDuration) {
//                self.view.layoutIfNeeded()
//            }
//        }
    }

    func showAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "Ok", style: .default) { _ in
//            alert.dismiss(animated: true, completion: nil)
//        }
//        alert.addAction(action)
//
//        navigationController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource

extension StarGazersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        starGazers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = starGazers[indexPath.row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: StarGazerTableViewCell.identifier, for: indexPath) as? StarGazerTableViewCell {
            cell.configure(with: cellModel)
//            cell.accessibilityIdentifier = "DataCell\(indexPath.row)"
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: UITableViewDelegate

extension StarGazersListViewController: UITableViewDelegate {
}

// MARK: UITableViewDataSourcePrefetching

extension StarGazersListViewController: UITableViewDataSourcePrefetching {
    private func isLoadingCell(at indexPath: IndexPath) -> Bool {
        return indexPath.row >= (starGazers.count - 1)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell(at:)) {
            presenter.fetchNewStarGazers()
        }
    }
}

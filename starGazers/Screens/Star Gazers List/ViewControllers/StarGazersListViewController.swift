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
    
    private let presenter: StarGazersListPresenterProtocol
    
    private var hasReachedLast: Bool = false
    private var starGazers: [StarGazer] = []
    
    private lazy var tableFooterView: UIView = {
        let spinnerView = UIActivityIndicatorView(style: .large)
        let footerView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: tableView.frame.width,
                height: Constant.tableFooterViewHeight
            )
        )

        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.startAnimating()
        footerView.addSubview(spinnerView)

        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])
        
        return footerView
    }()
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
        setTitle(presenter.title, color: UIColor.frontOrange)
        messageViewHeightConstraint.constant = Constant.collapsedMessageViewHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
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
        tableView.reloadData()
    }
    
    func showSpinner() {
        tableView.tableFooterView = self.tableFooterView
    }
        
    func hideSpinner() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func setHasReachEndOfData() {
        hasReachedLast = true
    }
    
    func displayMessage(text: String) {
        messageLabel.text = text
        messageViewHeightConstraint.constant = Constant.expandedMessageViewHeight

        UIView.animate(withDuration: Constant.animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: Private Methods

private extension StarGazersListViewController{
    enum Constant {
        static let tableRowHeight: CGFloat = 80
        static let tableFooterViewHeight: CGFloat = 60
        static let animationDuration: TimeInterval = 0.3
        static let expandedMessageViewHeight: CGFloat = 40
        static let collapsedMessageViewHeight: CGFloat = 0
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = .clear
        tableView.tableFooterView = tableFooterView
        tableView.rowHeight = Constant.tableRowHeight
        tableView.register(viewType: StarGazerTableViewCell.self)
    }

    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        customizeNavigationBar(backgroundColor: UIColor.backGrey, backButtonColor: UIColor.lightText)
    }
}

// MARK: UITableViewDataSource

extension StarGazersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        starGazers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use strategy
        if let cell = tableView.dequeueReusableCell(withIdentifier: StarGazerTableViewCell.identifier, for: indexPath) as? StarGazerTableViewCell {
            cell.configure(with: starGazers[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !hasReachedLast, indexPath.row == (starGazers.count - 1) {
            presenter.fetchNewStarGazers()
        }
    }
}

// MARK: UITableViewDelegate

extension StarGazersListViewController: UITableViewDelegate {}

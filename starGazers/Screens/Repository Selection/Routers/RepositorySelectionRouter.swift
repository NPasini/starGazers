//
//  RepositorySelectionRouter.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit

class RepositorySelectionRouter {
    private let httpClient: HTTPClientProtocol
    private weak var navigationController: UINavigationController?
    
    func setNavigationController(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Initializers
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
}
 
extension RepositorySelectionRouter: RepositorySelectionRouterProtocol {
    func navigateToStarGazersListScreen(repoName: String, repoOwner: String) {
        let assembler = StarGazersListScreenAssembler(httpClient: httpClient)
        navigationController?.pushViewController(
            assembler.assemble(repoName: repoName, repoOwner: repoOwner),
            animated: true
        )
    }

    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: buttonTitle, style: .default) { _ in
                alert.dismiss(animated: true, completion: nil)
            }
        )

        navigationController?.present(alert, animated: true, completion: nil)
    }
}

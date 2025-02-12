//
//  RepositorySelectionRouter.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit

class RepositorySelectionRouter {
    private var navigationController: UINavigationController?
    
    func setNavigationController(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
 
extension RepositorySelectionRouter: RepositorySelectionRouterProtocol {
    func navigateToStarGazersListScreen() {
        let viewController = UIViewController()
        navigationController?.pushViewController(viewController, animated: true)
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

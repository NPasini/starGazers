//
//  StarGazersListRouter.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit

class StarGazersListRouter {
    private weak var navigationController: UINavigationController?
}
 
extension StarGazersListRouter: StarGazersListRouterProtocol {
    func setNavigationController(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: buttonTitle, style: .default) { _ in
                alert.dismiss(animated: true, completion: nil)
            }
        )

        self.navigationController?.present(alert, animated: true, completion: nil)
    }
}

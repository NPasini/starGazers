//
//  StarGazersListRouterMainThreadDecorator.swift
//  starGazers
//
//  Created by nicolo.pasini on 13/02/25.
//

import UIKit

class StarGazersListRouterMainThreadDecorator {
    private let decoratee: StarGazersListRouterProtocol
    
    // MARK: Initializers
    
    init(decoratee: StarGazersListRouterProtocol) {
        self.decoratee = decoratee
    }
}

extension StarGazersListRouterMainThreadDecorator: StarGazersListRouterProtocol {
    func setNavigationController(_ navigationController: UINavigationController) {
        decoratee.setNavigationController(navigationController)
    }
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            self.decoratee.showAlert(title: title, message: message, buttonTitle: buttonTitle)
        }
    }
}

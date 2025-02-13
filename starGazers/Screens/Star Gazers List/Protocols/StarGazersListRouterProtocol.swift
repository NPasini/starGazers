//
//  StarGazersListRouterProtocol.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit

protocol StarGazersListRouterProtocol {
    func showAlert(title: String, message: String, buttonTitle: String)
    func setNavigationController(_ navigationController: UINavigationController)
}

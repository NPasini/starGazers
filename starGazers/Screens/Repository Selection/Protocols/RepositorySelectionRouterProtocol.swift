//
//  RepositorySelectionRouterProtocol.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

protocol RepositorySelectionRouterProtocol {
    func showAlert(title: String, message: String, buttonTitle: String)
    func navigateToStarGazersListScreen(repoName: String, repoOwner: String)
}

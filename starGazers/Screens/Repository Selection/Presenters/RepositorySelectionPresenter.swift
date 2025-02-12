//
//  RepositorySelectionPresenter.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

class RepositorySelectionPresenter {
    static let alertTitle = "Error"
    static let okButtonTitle = "Ok"
    static let errorMessage = "Please, insert both the repository name and the repository owner"
    
    private var model: RepositorySelectionModel
    private let router: RepositorySelectionRouterProtocol
    
    // MARK: Initializers
    
    init(model: RepositorySelectionModel, router: RepositorySelectionRouterProtocol) {
        self.model = model
        self.router = router
    }
}

extension RepositorySelectionPresenter: RepositorySelectionPresenterProtocol {
    func setRepositoryName(_ name: String) {
        model.setRepositoryName(name)
    }

    func setRepositoryOwner(_ owner: String) {
        model.setRepositoryOwner(owner)
    }
    
    func didTapOnConfirmButton() {
        if model.isValid() {
            router.navigateToStarGazersListScreen(
                repoName: model.repoName,
                repoOwner: model.repoOwner
            )
        } else {
            showErrorMessage()
        }
    }
}

private extension RepositorySelectionPresenter {
    func showErrorMessage() {
        router.showAlert(title: Self.alertTitle, message: Self.errorMessage, buttonTitle: Self.okButtonTitle)
    }
}

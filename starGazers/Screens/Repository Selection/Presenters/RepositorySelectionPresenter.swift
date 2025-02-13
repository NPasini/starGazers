//
//  RepositorySelectionPresenter.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

class RepositorySelectionPresenter {
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

// MARK: Private Methods

private extension RepositorySelectionPresenter {
    enum Constant {
        static let alertTitle = "Error"
        static let okButtonTitle = "Ok"
        static let errorMessage = "Please, insert both the repository name and the repository owner"
    }
    
    func showErrorMessage() {
        router.showAlert(title: Constant.alertTitle, message: Constant.errorMessage, buttonTitle: Constant.okButtonTitle)
    }
}

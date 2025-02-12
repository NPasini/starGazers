//
//  RepositorySelectionPresenter.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

class RepositorySelectionPresenter {
    static let okButtonTitle = "Ok"
    static let errorMessage = "Please, insert both the repository name and the repository owner"
    
    private var model: RepositorySelectorModel

//    func showErrorMessage() {
//        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
//        alert.addAction(
//            UIAlertAction(title: okButtonTitle, style: .default) { _ in
//                alert.dismiss(animated: true, completion: nil)
//            }
//        )
//
//        navigationController?.present(alert, animated: true, completion: nil)
//    }
    
    // MARK: Initializers
    
    init(model: RepositorySelectorModel) {
        self.model = model
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
//            navigateToGazerListPage()
        } else {
//            showErrorMessage()
        }
    }
}

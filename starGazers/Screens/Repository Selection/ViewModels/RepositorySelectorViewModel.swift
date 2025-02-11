//
//  RepositorySelectorViewModel.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

class RepositorySelectorViewModel: RepositorySelectorViewModelProtocol {
    private var repositoryName: String
    private var repositoryOwner: String

    init() {
        repositoryName = ""
        repositoryOwner = ""
    }

    func setRepositoryName(_ name: String) {
        repositoryName = name
    }

    func setRepositoryOwner(_ owner: String) {
        repositoryOwner = owner
    }

    func isValid() -> Bool {
        !repositoryName.isEmpty && !repositoryOwner.isEmpty
    }

    func errorMessage() -> String {
        "Please, insert both the repository name and the repository owner"
    }
}

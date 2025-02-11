//
//  RepositorySelectorViewModelProtocol.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

protocol RepositorySelectorViewModelProtocol {
    func isValid() -> Bool
    func errorMessage() -> String
    func setRepositoryName(_ name: String)
    func setRepositoryOwner(_ owner: String)
}

//
//  RepositorySelectionPresenterProtocol.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

protocol RepositorySelectionPresenterProtocol: AnyObject {
    func didTapOnConfirmButton()
    func setRepositoryName(_ name: String)
    func setRepositoryOwner(_ owner: String)
}

//
//  StarGazersListScreenAssembler.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit

struct StarGazersListScreenAssembler {
    private static let starGazersListStoryboardName = "StarGazersList"
    
    private let httpClient: HTTPClientProtocol
    
    func assemble(repoName: String, repoOwner: String) -> UIViewController {
        let presenter = StarGazersListPresenter(
            interactor: StarGazersListInteractor(
                entity: .init(repoName: repoName, repoOwner: repoOwner),
                httpClient: httpClient
            )
        )
        
        let storyBoard = UIStoryboard(name: Self.starGazersListStoryboardName, bundle: .main)
        let viewController = storyBoard.instantiateInitialViewController {
            StarGazersListViewController(coder: $0, presenter: presenter)
        }
        
        guard let vc = viewController else {
            fatalError("Not able to instatiate correct view controller")
        }
        
        presenter.view = vc
        
        return vc
    }
    
    // MARK: Initializers
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
}

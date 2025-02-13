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
    private let navigationController: UINavigationController
    
    func assemble(repoName: String, repoOwner: String) -> UIViewController {
        let router = StarGazersListRouterMainThreadDecorator(
            decoratee: StarGazersListRouter()
        )
        let presenter = StarGazersListPresenter(
            interactor: StarGazersListInteractor(
                entity: .init(repoName: repoName, repoOwner: repoOwner),
                dataSource: StarGazersDataSource(httpClient: httpClient)
            ),
            router: router
        )
        
        let storyBoard = UIStoryboard(name: Self.starGazersListStoryboardName, bundle: .main)
        let viewController = storyBoard.instantiateInitialViewController {
            StarGazersListViewController(coder: $0, presenter: presenter)
        }
        
        guard let vc = viewController else {
            fatalError("Not able to instatiate correct view controller")
        }
        
        presenter.view = vc
        router.setNavigationController(navigationController)
        
        return vc
    }
    
    // MARK: Initializers
    
    init(httpClient: HTTPClientProtocol, navigationController: UINavigationController) {
        self.httpClient = httpClient
        self.navigationController = navigationController
    }
}

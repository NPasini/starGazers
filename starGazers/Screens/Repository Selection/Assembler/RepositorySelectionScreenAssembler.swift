//
//  RepositorySelectionScreenAssembler.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit

struct RepositorySelectionScreenAssembler {
    private static let repoSelectioStoryboardName = "RepositorySelection"
    
    static func assemble() -> UIViewController {
        let router = RepositorySelectionRouter()
        let presenter = RepositorySelectionPresenter(
            model: .init(),
            router: router
        )
        
        let repoSelectionStoryboard = UIStoryboard(name: repoSelectioStoryboardName, bundle: .main)
        let viewController = repoSelectionStoryboard.instantiateInitialViewController {
            RepositorySelectionViewController(coder: $0, presenter: presenter)
        }
        
        guard let vc = viewController else {
            fatalError("Not able to instatiate correct view controller")
        }
        
        let navigationController = UINavigationController(rootViewController: vc)
        router.setNavigationController(navigationController)
        
        return navigationController
    }
}

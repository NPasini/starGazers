//
//  RepositorySelectionScreenAssembler.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit

struct RepositorySelectionScreenAssembler {
    static func assemble(coder: NSCoder) -> RepositorySelectionViewController {
        let presenter = RepositorySelectionPresenter(model: .init())
        guard let viewController = RepositorySelectionViewController(coder: coder, presenter: presenter) else {
            fatalError("Not able to instatiate correct view controller")
        }
        
        return viewController
    }
}

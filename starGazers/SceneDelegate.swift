//
//  SceneDelegate.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private static let repoSelectioStoryboardName = "RepositorySelection"
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        let repoSelectionStoryboard = UIStoryboard(name: Self.repoSelectioStoryboardName, bundle: .main)
        window?.rootViewController = repoSelectionStoryboard.instantiateInitialViewController { RepositorySelectionScreenAssembler.assemble(coder: $0)
        }
        window?.makeKeyAndVisible()
    }
}

//
//  SceneDelegate.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        window?.rootViewController = RepositorySelectionScreenAssembler.assemble()
        window?.makeKeyAndVisible()
    }
}

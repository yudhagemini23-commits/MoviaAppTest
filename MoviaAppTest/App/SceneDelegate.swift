//
//  SceneDelegate.swift
//  MoviaAppTest
//
//  Created by Yudha Pratama Putra on 2/4/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootVC = MovieViewController(nibName: "MovieViewController", bundle: nil)
        let navVC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

//
//  SceneDelegate.swift
//  TunedGlobal
//
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let navControllerId = "StoryboardNavController"
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame:UIScreen.main.bounds)

        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let navController = storyBoard.instantiateViewController(identifier: navControllerId) as! UINavigationController
        
        let initialVc = navController.viewControllers.first as! TrendingAlbumsViewController
        initialVc.store = PhotoStore()
        
        navController.navigationBar.prefersLargeTitles = true
        window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = navController
        window?.windowScene = scene
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {    }

    func sceneDidBecomeActive(_ scene: UIScene) {    }

    func sceneWillResignActive(_ scene: UIScene) {    }

    func sceneWillEnterForeground(_ scene: UIScene) {    }

    func sceneDidEnterBackground(_ scene: UIScene) {    }


}


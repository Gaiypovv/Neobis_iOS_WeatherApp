//
//  SceneDelegate.swift
//  WeatherAPPEldarFinal
//
//  Created by Eldar Gaiypov on 27/5/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        window = UIWindow(windowScene: windowScene)

        let weatherViewModel = WeatherViewModel()
        let weekViewModel = WeekViewModel() // Assume you have a WeekViewModel class implementing WeekViewModelType
        let viewController = ViewController(vm: weatherViewModel, vm2: weekViewModel)
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Perform any tasks when the scene is about to become inactive.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Undo any changes made when the scene entered the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save data, release shared resources, and store enough scene-specific state information to restore the scene.
    }
}

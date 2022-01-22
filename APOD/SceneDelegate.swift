//
//  SceneDelegate.swift
//  APOD
//
//  Created by Sakiwei on 7/1/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene,
           let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let window = UIWindow(windowScene: windowScene)
            let appService = appDelegate.appService!
            window.rootViewController = entryPoint(withAppService: appService)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    // tab
    private func entryPoint(withAppService appService: AppServiceContainer) -> UIViewController {
        return TabModuleBuilderImpl()
            .build(enviroment: appService.enviroment,
                   apiClient: appService.apiClient,
                   tabViews: [
                    root(withAppService: appService),
                    list(withAppService: appService)
                   ])
    }

    // root
    private func root(withAppService appService: AppServiceContainer) -> UIViewController {
        return RootModuleBuilderImpl()
            .build(enviroment: appService.enviroment,
                   apiClient: appService.apiClient)
    }

    // list
    private func list(withAppService appService: AppServiceContainer) -> UIViewController {
        return ListModuleBuilderImpl()
            .build(enviroment: appService.enviroment,
                   apiClient: appService.apiClient)
    }
}


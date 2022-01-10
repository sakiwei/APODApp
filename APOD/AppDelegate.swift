//
//  AppDelegate.swift
//  APOD
//
//  Created by Sakiwei on 7/1/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appService: AppServiceContainer!
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let enviroment = Enviroment.development
        appService = DefaultAppServiceContainer(enviroment: enviroment)
        customizeNavigationControllerStyle()
        return true
    }
}

// MARK: - AppDelegate Scene Lifecycle Support
extension AppDelegate {
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

// MARK: - Update navigation bar styles
extension AppDelegate {
    func customizeNavigationControllerStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().tintColor = UIColor.systemOrange
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

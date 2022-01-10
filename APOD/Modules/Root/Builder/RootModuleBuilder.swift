//
//  RootModuleBuilder.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import UIKit
import Networking

protocol RootModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient) -> UIViewController
}

final class RootModuleBuilderImpl: RootModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient) -> UIViewController {
        let view = RootViewController()
        let service = FetchDailyPictureServiceImpl(enviroment: enviroment,
                                                   apiClient: apiClient)
        let interactor = RootInteractorImpl(service: service)
        let router = RootRouterImpl(controller: view)
        let presenter = RootPresenterImpl(view: view,
                                          interactor: interactor,
                                          router: router)
        view.presenter = presenter
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}

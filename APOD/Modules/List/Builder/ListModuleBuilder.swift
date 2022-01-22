//
//  ListModuleBuilder.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import UIKit
import Networking

protocol ListModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient) -> UIViewController
}

final class ListModuleBuilderImpl: ListModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient) -> UIViewController {
        let view = ListViewController()
        let service = FetchDailyPictureServiceImpl(enviroment: enviroment, apiClient: apiClient)
        let interactor = ListInteractorImpl(service: service)
        let router = ListRouterImpl(controller: view)
        let presenter = ListPresenterImpl(view: view,
                                          interactor: interactor,
                                          router: router)
        view.presenter = presenter
        return UINavigationController(rootViewController: view)
    }
}

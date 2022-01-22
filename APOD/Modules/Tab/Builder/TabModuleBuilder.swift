//
//  TabModuleBuilder.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import UIKit
import Networking

protocol TabModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient,
               tabViews: [UIViewController]) -> UIViewController
}

final class TabModuleBuilderImpl: TabModuleBuilder {
    func build(enviroment: Enviroment,
               apiClient: APIClient,
               tabViews: [UIViewController]) -> UIViewController {
        let view = TabViewController()
        view.viewControllers = tabViews

        let interactor = TabInteractorImpl()
        let router = TabRouterImpl(controller: view)
        let presenter = TabPresenterImpl(view: view,
                                         interactor: interactor,
                                         router: router)
        view.presenter = presenter
        return view
    }
}

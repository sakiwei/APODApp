//
//  TabRouter.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation

protocol TabRouter {
}

protocol TabRouteNavigatable: AnyObject {
}

final class TabRouterImpl: TabRouter {
    weak var controller: TabRouteNavigatable?

    init(controller: TabRouteNavigatable) {
        self.controller = controller
    }
}

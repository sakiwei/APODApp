//
//  ListRouter.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation

protocol ListRouter {
}

protocol ListRouteNavigatable: AnyObject {
}

final class ListRouterImpl: ListRouter {
    weak var controller: ListRouteNavigatable?

    init(controller: ListRouteNavigatable) {
        self.controller = controller
    }
}

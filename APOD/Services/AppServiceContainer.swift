//
//  AppServiceContainer.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import Networking

protocol AppServiceContainer {
    var enviroment: Enviroment { get }
    var apiClient: APIClient { get }
}

final class DefaultAppServiceContainer: AppServiceContainer {
    let apiClient: APIClient = makeAPIClient(cache: makeCache())
    let enviroment: Enviroment

    init(enviroment: Enviroment) {
        self.enviroment = enviroment
    }

    private static func makeCache() -> Cache {
        let allowedDiskSize = 200 * 1024 * 1024
        return DefaultCache(urlCache: URLCache(memoryCapacity: 0,
                                               diskCapacity: allowedDiskSize,
                                               diskPath: "api_request"))
    }

    private static func makeAPIClient(cache: Cache) -> APIClient {
        return DefaultAPIClient(sessionManager: makeSessionManager(cache: cache))
    }

    private static func makeSessionManager(cache: Cache) -> SessionManager {
        return DefaultSessionManager(cache: cache)
    }
}

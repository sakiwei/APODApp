//
//  Cache.swift
//  
//
//  Created by Sakiwei on 10/1/2022.
//

import Foundation

public protocol CachedNetworkResult {
    var response: URLResponse { get }
    var data: Data { get }
}

public protocol Cache {
    func storeCache(response: URLResponse, data: Data, for urlRequest: URLRequest)
    func retriveCache(from urlRequest: URLRequest) -> CachedNetworkResult?
}

public final class DefaultCache: Cache {
    private let urlCache: URLCache
    public init(urlCache: URLCache) {
        self.urlCache = urlCache
    }
    
    public func storeCache(response: URLResponse, data: Data, for urlRequest: URLRequest) {
        self.urlCache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: urlRequest)
    }

    public func retriveCache(from urlRequest: URLRequest) -> CachedNetworkResult? {
        return self.urlCache.cachedResponse(for: urlRequest)
    }
}

extension CachedURLResponse: CachedNetworkResult {
}

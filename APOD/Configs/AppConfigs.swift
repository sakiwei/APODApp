//
//  AppConfigs.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation

protocol AppConfigs {
    var nasaApodKey: String { get }
}

enum Enviroment {
    case development
}

extension Enviroment: AppConfigs {
    var nasaApodKey: String {
        switch self {
        default:
            // NOTE: please test with your own API Key
            // sign up link: https://api.nasa.gov/#signUp
            return "DEMO_KEY"
        }
    }
}

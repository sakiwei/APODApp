//
//  RootView.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import DataModel

protocol RootView: AnyObject {

    @MainActor
    func pictureContentDidLoad(_ content: AstronomyPicture)

    @MainActor
    func showLoadingIndicator()

    @MainActor
    func hideLoadingIndicator()

    @MainActor
    func showError(message: String)
}

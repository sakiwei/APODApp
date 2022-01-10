//
//  RootView.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation

protocol RootView: AnyObject {

    @MainActor
    func pictureContentDidLoad(_ content: PictureViewModel)

    @MainActor
    func showLoadingIndicator()

    @MainActor
    func hideLoadingIndicator()

    @MainActor
    func showError(message: String)
}

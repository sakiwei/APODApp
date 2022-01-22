//
//  ListView.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import DataModel

protocol ListView: AnyObject {
    @MainActor
    func pictureListDidLoad(_ content: [AstronomyPicture])

    @MainActor
    func showLoadingIndicator()

    @MainActor
    func hideLoadingIndicator()

    @MainActor
    func showError(message: String)
}

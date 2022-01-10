//
//  PictureViewModel.swift
//  APOD
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation
import DataModel

protocol PictureViewModel {
    var date: String { get }
    var explanation: String { get }
    var title: String { get }
    var url: String { get }
    var mediaType: String { get }
    var hdurl: String? { get }
}

extension AstronomyPicture: PictureViewModel {
}

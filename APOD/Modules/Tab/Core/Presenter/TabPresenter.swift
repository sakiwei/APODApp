//
//  TabPresenter.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import SwiftUI

protocol TabPresenter: AnyObject {

}

class TabPresenterImpl: TabPresenter {
    weak var view: TabView?
    var interactor: TabInteractor
    var router: TabRouter

    init(view: TabView,
         interactor: TabInteractor,
         router: TabRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

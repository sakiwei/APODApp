//
//  TabInteractor.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation

protocol TabInteractor {

}

class TabInteractorImpl: TabInteractor {
    weak var presenter: TabPresenter?
}

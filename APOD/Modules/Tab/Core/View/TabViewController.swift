//
//  TabViewController.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import UIKit

class TabViewController: UITabBarController {
    var presenter: TabPresenter!

    override func loadView() {
        super.loadView()
        self.tabBar.tintColor = .systemOrange
    }
}

extension TabViewController: TabView {

}

extension TabViewController: TabRouteNavigatable {

}

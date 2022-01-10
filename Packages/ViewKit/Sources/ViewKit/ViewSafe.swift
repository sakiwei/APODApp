//
//  ViewSafe.swift
//
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import UIKit

// By comforming `ViewSafe`, it allows View Controller's view to become type-safe
public protocol ViewSafe {
    associatedtype ViewType: UIView
}

public extension ViewSafe where Self: UIViewController {
    var typeSafeView: ViewType {
        return view as! ViewType
    }

    func createTypeSafeView() -> ViewType {
        return ViewType.self(frame: view.frame)
    }
}

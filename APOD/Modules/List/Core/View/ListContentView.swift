//
//  ListContentView.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import UIKit
import SnapKit

class ListContentView: UIView {

    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.backgroundColor = .systemBackground
        addSubview(tableView)

        createConstraints()
    }

    private func createConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

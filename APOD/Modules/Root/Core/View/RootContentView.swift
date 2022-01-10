//
//  RootContentView.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import UIKit
import SnapKit
import ViewKit

final class RootContentView: UIView {

    let scrollView = UIScrollView()
    let contentView = PictureDescriptionView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.backgroundColor = .systemBackground
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        createConstraints()
    }

    private func createConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self)
        }
    }
}

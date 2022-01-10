//
//  PictureDescriptionView.swift
//  
//
//  Created by Sakiwei on 9/1/2022.
//

import Foundation
import UIKit
import SnapKit

public final class PictureDescriptionView: UIView {

    public let coverImageView = UIImageView()
    public let titleLabel = UILabel()
    public let dateLabel = UILabel()
    public let explainlabel = UILabel()
    public let viewButton = UIButton(type: .custom)
    public var onViewContent: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {

        // add subviews
        [coverImageView, dateLabel, titleLabel, explainlabel, viewButton].forEach { view in
            addSubview(view)
        }

        createConstraints()
        stylingViews()

        // bind subviews
        viewButton.addTarget(self, action: #selector(viewContent), for: .touchUpInside)

        coverImageView.accessibilityIdentifier = "Cover Image"
        titleLabel.accessibilityIdentifier = "Title"
        dateLabel.accessibilityIdentifier = "Date"
        explainlabel.accessibilityIdentifier = "Explanation"
        viewButton.accessibilityIdentifier = "View Button"
    }

    private func compactLayout() {
        coverImageView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(coverImageView.snp.width).multipliedBy(0.75)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(16)
            make.left.right.equalTo(titleLabel)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.rightMargin.leftMargin.equalToSuperview().inset(16)
        }

        explainlabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(16)
        }

        viewButton.snp.makeConstraints { make in
            make.edges.equalTo(coverImageView)
        }
    }

    private func regularLayout() {
        coverImageView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.greaterThanOrEqualTo(400)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(16)
            make.left.right.equalTo(titleLabel)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.left.right.equalTo(coverImageView)
        }

        explainlabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    private func createConstraints(isOrientationUpdated: Bool = false) {
        if isOrientationUpdated {
            [coverImageView, titleLabel, dateLabel, explainlabel].forEach { view in
                view.snp.removeConstraints()
            }
        }

        if self.traitCollection.verticalSizeClass == .compact && UIDevice.current.userInterfaceIdiom == .phone {
            regularLayout()
        } else if self.traitCollection.horizontalSizeClass == .compact {
            compactLayout()
        } else {
            regularLayout()
        }
    }

    private func stylingViews() {
        self.backgroundColor = .systemBackground

        coverImageView.backgroundColor = .systemGray6
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true

        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true

        dateLabel.numberOfLines = 0
        dateLabel.textColor = .secondaryLabel
        dateLabel.font = .preferredFont(forTextStyle: .subheadline)
        dateLabel.adjustsFontForContentSizeCategory = true

        explainlabel.numberOfLines = 0
        explainlabel.textColor = .label
        explainlabel.font = .preferredFont(forTextStyle: .body)
        explainlabel.adjustsFontForContentSizeCategory = true

        viewButton.tintColor = .white
        viewButton.layer.shadowRadius = 10
        viewButton.layer.shadowColor = UIColor.black.cgColor
        viewButton.layer.shadowOpacity = 0.3
    }

    @objc private func viewContent() {
        onViewContent?()
    }
}

// MARK: - orientation change
extension PictureDescriptionView {
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        createConstraints(isOrientationUpdated: true)
    }
}

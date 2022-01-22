//
//  ApodListCell.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import UIKit
import SnapKit
import DataModel
import Kingfisher

final class ApodListCell: UITableViewCell {
    let apodImageView = UIImageView()
    let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func commonInit() {
        self.contentView.addSubview(apodImageView)
        self.contentView.addSubview(label)

        createContraints()
        stylingViews()
    }

    private func createContraints() {
        self.apodImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        self.label.snp.makeConstraints { make in
            make.top.equalTo(self.apodImageView.snp.bottom).offset(12)
            make.bottom.left.right.equalToSuperview().inset(16)
        }

        self.apodImageView.snp.makeConstraints { make in
            make.width.equalTo(self.apodImageView.snp.height).multipliedBy(4.0/3.0)
        }
    }

    private func stylingViews() {
        self.apodImageView.backgroundColor = .systemGray6
        self.apodImageView.contentMode = .scaleAspectFill
        self.apodImageView.clipsToBounds = true

        self.label.numberOfLines = 0
    }

    func bind(_ picture: AstronomyPicture) {
        apodImageView.kf.setImage(with: URL(string: picture.url))
        let titleAttrString = NSAttributedString(string: picture.title,
                                                 attributes: [
                                                    .foregroundColor: UIColor.label,
                                                    .font: UIFont.preferredFont(forTextStyle: .headline)])
        let dateString = picture.date.formatted(
            LocalizedDateFormat(locale: Locale(identifier: "en_US"),
                                format: "yyyy-MM-dd"),
            to: LocalizedDateFormat(locale: Locale.current,
                                    format: "ddMMMMyyyy")) ?? ""
        let dateAttrString = NSAttributedString(string: "\n\(dateString)",
                                                attributes: [
                                                    .foregroundColor: UIColor.secondaryLabel,
                                                    .font: UIFont.preferredFont(forTextStyle: .subheadline)])
        let final = NSMutableAttributedString(attributedString: titleAttrString)
        final.append(dateAttrString)
        label.attributedText = final
    }
}

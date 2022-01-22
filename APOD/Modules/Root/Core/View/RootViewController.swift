//
//  RootViewController.swift
//  APOD
//
//  Created by Sakiwei on 8/1/2022.
//

import Foundation
import UIKit
import FoundationKit
import ViewKit
import Kingfisher
import DataModel

final class RootViewController: UIViewController, ViewSafe {
    typealias ViewType = RootContentView
    var presenter: RootPresenter!
    var disposeBag: [Task<(), Never>] = []

    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        title = "Astronomy Picture of the Day"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = createTypeSafeView()
        showCalenderButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
    }
    
    @objc func selectDate() {
        presenter.openDatePicker()
    }
    
    private func showCalenderButton() {
        let barButtonItem = UIBarButtonItem(imageSystemName: "calendar",
                                        style: .plain,
                                        target: self,
                                        action: #selector(selectDate))
        barButtonItem.accessibilityIdentifier = "Show Calendar"
        navigationItem.rightBarButtonItem = barButtonItem
        
    }
}

extension RootViewController: RootView {
    func pictureContentDidLoad(_ content: AstronomyPicture) {
        typeSafeView.contentView.titleLabel.text = content.title
        typeSafeView.contentView.dateLabel.text = content.date.formatted(
            LocalizedDateFormat(locale: Locale(identifier: "en_US"),
                                format: "yyyy-MM-dd"),
            to: LocalizedDateFormat(locale: Locale.current,
                                    format: "ddMMMMyyyy"))
        typeSafeView.contentView.explainlabel.text = content.explanation
        let coverImageView = typeSafeView.contentView.coverImageView
        let processor = DownsamplingImageProcessor(size: coverImageView.bounds.size)
        coverImageView.kf.indicatorType = .activity
        if content.mediaType == "image" {
            coverImageView.kf.setImage(with: URL(string: content.url),
                                       options: [
                                        .processor(processor),
                                        .transition(.fade(1))
                                       ])
            typeSafeView.contentView.viewButton.isEnabled = true
            typeSafeView.contentView.viewButton.setImage(nil, for: .normal)
            typeSafeView.contentView.onViewContent =  nil
        } else if content.mediaType == "video" {
            if let youtubeID = content.url.youtubeID {
                let thumbnailURL = URL(string: "https://img.youtube.com/vi/\(youtubeID)/hqdefault.jpg")
                coverImageView.kf.setImage(with: thumbnailURL,
                                           options: [
                                            .processor(processor),
                                            .transition(.fade(1))
                                           ])
            } else {
                coverImageView.image = nil
            }
            typeSafeView.contentView.viewButton.isEnabled = true
            let playIcon = UIImage(systemName: "play",
                                   withConfiguration:
                                    UIImage.SymbolConfiguration(pointSize: 40, weight: .medium))
            typeSafeView.contentView.viewButton.setImage(playIcon, for: .normal)
            typeSafeView.contentView.onViewContent = { [unowned self] in
                if let url = URL(string: content.url) {
                    self.openExternalURL(url)
                }
            }
        } else {
            coverImageView.image = nil
            typeSafeView.contentView.viewButton.isEnabled = false
            typeSafeView.contentView.viewButton.setImage(nil, for: .normal)
            typeSafeView.contentView.onViewContent = nil
        }
    }
    
    func showLoadingIndicator() {
        let activityView = UIActivityIndicatorView()
        activityView.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityView)
        activityView.startAnimating()
    }
    
    func hideLoadingIndicator() {
        showCalenderButton()
    }

    func showError(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openExternalURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: "Unable to open this url...", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension RootViewController: RootRouteNavigatable {
    func present(withDatePicker datePicker: UIViewController) {
        datePicker.modalPresentationStyle = .popover
        let popover = datePicker.popoverPresentationController
        if let delegate = datePicker as? UIPopoverPresentationControllerDelegate {
            popover?.delegate = delegate
        }
        popover?.barButtonItem = self.navigationItem.rightBarButtonItem
        popover?.permittedArrowDirections = .any
        self.present(datePicker, animated: true, completion: nil)
    }
}

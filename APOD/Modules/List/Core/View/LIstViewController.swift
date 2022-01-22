//
//  ListViewController.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation
import UIKit
import ViewKit
import DataModel

class ListViewController: UIViewController, ViewSafe {
    typealias ViewType = ListContentView
    var presenter: ListPresenter!
    lazy var dataSource = makeDataSource()

    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        title = "Last 7 days pictures"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = createTypeSafeView()
        typeSafeView.tableView.dataSource = dataSource
        typeSafeView.tableView.register(ApodListCell.self, forCellReuseIdentifier: "\(ApodListCell.self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ListViewController: ListView {
    func pictureListDidLoad(_ content: [AstronomyPicture]) {
        self.update(with: content)
    }

    func showLoadingIndicator() {

    }

    func hideLoadingIndicator() {

    }

    func showError(message: String) {

    }
}

extension ListViewController {
    enum Section: CaseIterable {
        case apod
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, AstronomyPicture> {
        return UITableViewDiffableDataSource(
            tableView: typeSafeView.tableView,
            cellProvider: {  tableView, indexPath, viewModel in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ApodListCell.self)", for: indexPath) as? ApodListCell else  {
                    return UITableViewCell()
                }
                cell.bind(viewModel)
                return cell
            }
        )
    }

    func update(with pictures: [AstronomyPicture], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AstronomyPicture>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(pictures, toSection: .apod)
        self.dataSource.apply(snapshot, animatingDifferences: animate)
    }
}


extension ListViewController: ListRouteNavigatable {

}

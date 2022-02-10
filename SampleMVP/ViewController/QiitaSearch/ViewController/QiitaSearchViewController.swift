//
//  QiitaSearchViewController.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/07.
//

import UIKit

final class QiitaSearchViewController: UIViewController {

    private var presenter: QiitaSearchPresenterInput!
    
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(QiitaTableViewCell.nib, forCellReuseIdentifier: QiitaTableViewCell.identifier)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        tableView.isHidden = true
    }

    func inject(with presenter: QiitaSearchPresenterInput) {
        self.presenter = presenter
    }
}

extension QiitaSearchViewController: QiitaSearchPresenterOutput {
    func update(loding: Bool) {
        DispatchQueue.main.async {
            self.indicator.isHidden = !loding
            self.tableView.isHidden = loding
        }
    }

    func didFetch(qiitaModels: [QiitaModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func failToFetch(error: Error) {
        DispatchQueue.main.async {
            self.showError(title: "エラー", message: error.localizedDescription)
        }
    }
}

extension QiitaSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter.search(searchWord: searchBar.text)
    }
}

extension QiitaSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let qiitaModel = presenter.item(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: QiitaTableViewCell.identifier, for: indexPath) as! QiitaTableViewCell
        cell.configure(qiitaModel: qiitaModel)
        return cell
    }
}

extension QiitaSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let qiitaModel = presenter.item(index: indexPath.row)
        Router.shared.showWeb(from: self, qiitaModel: qiitaModel)
    }
}

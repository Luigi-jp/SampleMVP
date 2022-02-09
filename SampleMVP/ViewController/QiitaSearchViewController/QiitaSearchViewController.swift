//
//  QiitaSearchViewController.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/07.
//

import UIKit

final class QiitaSearchViewController: UIViewController {
    
    private var qiitaModels: [QiitaModel] = []

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
    }
}

extension QiitaSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        indicator.isHidden = false
        tableView.isHidden = true
        guard let searchWord = searchBar.text else { return }
        QiitaAPI.shared.requestPosts(searchWord: searchWord) { result in
            DispatchQueue.main.async {
                self.indicator.isHidden = true
                self.tableView.isHidden = false
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let qiitaResponse):
                    self.qiitaModels = qiitaResponse
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension QiitaSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qiitaModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let qiitaModel = qiitaModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: QiitaTableViewCell.identifier, for: indexPath) as! QiitaTableViewCell
        cell.configure(qiitaModel: qiitaModel)
        return cell
    }
}

extension QiitaSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let qiitaModel = qiitaModels[indexPath.row]
        Router.shared.showWeb(from: self, url: qiitaModel.url)
    }
}

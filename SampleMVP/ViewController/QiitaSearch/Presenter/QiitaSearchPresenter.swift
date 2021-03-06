//
//  QiitaSearchPresenter.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/07.
//

import Foundation

protocol QiitaSearchPresenterInput: AnyObject {
    var numberOfItems: Int { get }
    func item(index: Int) -> QiitaModel
    func search(parameter: QiitaAPIParameters)
}

protocol QiitaSearchPresenterOutput: AnyObject {
    func update(loding: Bool)
    func didFetch(qiitaModels: [QiitaModel])
    func failToFetch(error: Error)
}

final class QiitaSearchPresenter {
    
    private weak var output: QiitaSearchPresenterOutput!
    private var apiInput: QiitaAPIInput!
    private var qiitaModels: [QiitaModel] = []

    init(output: QiitaSearchPresenterOutput, apiInput: QiitaAPIInput = QiitaAPI.shared) {
        self.output = output
        self.apiInput = apiInput
    }
}

extension QiitaSearchPresenter: QiitaSearchPresenterInput {
    var numberOfItems: Int {
        qiitaModels.count
    }

    func item(index: Int) -> QiitaModel {
        return qiitaModels[index]
    }
    
    func search(parameter: QiitaAPIParameters) {
        output.update(loding: true)
        apiInput.fetch(parameter: parameter) { [weak self] result in
            self?.output.update(loding: false)
            switch result {
            case .failure(let error):
                self?.output.failToFetch(error: error)
            case .success(let qiitaResponse):
                self?.qiitaModels = qiitaResponse
                self?.output.didFetch(qiitaModels: qiitaResponse)
            }
        }
    }
}

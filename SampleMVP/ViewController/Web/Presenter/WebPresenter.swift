//
//  WebPresenter.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/10.
//

import Foundation

protocol WebInput: AnyObject {
    func viewDidload()
}

protocol WebOutput: AnyObject {
    func load(request: URLRequest)
}

final class WebPresenter {
    private weak var output: WebOutput!
    private var qiitaModel: QiitaModel

    init(output: WebOutput, qiitaModel: QiitaModel) {
        self.output = output
        self.qiitaModel = qiitaModel
    }
}

extension WebPresenter: WebInput {
    func viewDidload() {
        guard let url = qiitaModel.url else { return }
        output.load(request: URLRequest(url: url))
    }
}

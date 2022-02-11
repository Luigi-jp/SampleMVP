//
//  QiitaAPI.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/07.
//

import Foundation

enum QiitaError: Error, LocalizedError {
    case unknown
    case connect
    case parse
    case validate

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "不明なエラーが発生しました。"
        case .connect:
            return "接続に失敗しました。"
        case .parse:
            return "データの解析に失敗しました。"
        case .validate:
            return "検索ワードを入力してください。"
        }
    }
}

struct QiitaAPIParameters {
    let searchWord: String?
    var _searchWord: String { searchWord ?? "" }
    let page: Int = 1
    let perPage: Int = 20

    var validation: Bool {
        !_searchWord.isEmpty && _searchWord.count > 0
    }

    var queryParameter: String {
        "page=\(page)&per_page=\(perPage)&query=\(_searchWord)"
    }
}

protocol QiitaAPIInput: AnyObject {
    func fetch(parameter: QiitaAPIParameters, completion: @escaping ((Result<[QiitaModel], QiitaError>) -> Void))
}

final class QiitaAPI: QiitaAPIInput {
    static let shared = QiitaAPI()
    private init() {}
    
    func fetch(parameter: QiitaAPIParameters, completion: @escaping ((Result<[QiitaModel], QiitaError>) -> Void)) {
        guard parameter.validation else {
            completion(.failure(.validate))
            return
        }
        guard let url = URL(string: "https://qiita.com/api/v2/items?\(parameter.queryParameter)") else {
            completion(.failure(.unknown))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(.unknown))
                return
            }
            guard let data = data,
                  let QiitaResponse: [QiitaModel] = try? JSONDecoder().decode([QiitaModel].self, from: data) else {
                      completion(.failure(.parse))
                      return
                  }
            completion(.success(QiitaResponse))
        }
        task.resume()
    }
}

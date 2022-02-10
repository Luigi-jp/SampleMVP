//
//  QiitaAPI.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/07.
//

import Foundation

struct QiitaAPIParameters {
    let searchWord: String?
    let page: Int = 1
    let perPage: Int = 20
}

protocol QiitaAPIInput: AnyObject {
    func fetch(searchWord: String, completion: @escaping ((Result<[QiitaModel], Error>) -> Void))
}

final class QiitaAPI: QiitaAPIInput {
    static let shared = QiitaAPI()
    private init() {}
    
    func fetch(searchWord: String, completion: @escaping ((Result<[QiitaModel], Error>) -> Void)) {
        guard !searchWord.isEmpty, searchWord.count > 0 else { return }
        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=20&query=\(searchWord)") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let QiitaResponse: [QiitaModel] = try? JSONDecoder().decode([QiitaModel].self, from: data) else {
                      return
                  }
            completion(.success(QiitaResponse))
        }
        task.resume()
    }
}

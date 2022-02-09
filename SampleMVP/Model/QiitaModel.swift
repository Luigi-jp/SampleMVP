//
//  QiitaModel.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/08.
//

import Foundation

struct QiitaModel: Codable {
    let title: String
    let updatedAt: String
    let urlStr: String
    let user: QiitaUser
    var userName: String { user.id }
    var url : URL? { URL(string: urlStr) }

    enum CodingKeys: String, CodingKey {
        case title
        case updatedAt = "updated_at"
        case urlStr = "url"
        case user
    }
}

struct QiitaUser: Codable {
    let id: String
}

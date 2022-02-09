//
//  QiitaTableViewCell.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/08.
//

import UIKit

final class QiitaTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    func configure(qiitaModel: QiitaModel) {
        titleLable.text = qiitaModel.title
        nameLabel.text = qiitaModel.userName
        dateLabel.text = qiitaModel.updatedAt
    }
}

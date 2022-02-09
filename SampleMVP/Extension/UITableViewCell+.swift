//
//  TableViewCell+.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/08.
//

import UIKit

extension UITableViewCell {
    static var identifier: String { String(describing: Self.self) }
    static var nib: UINib { UINib(nibName: identifier, bundle: nil) }
}

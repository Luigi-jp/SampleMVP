//
//  Storyboard+.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/07.
//

import Foundation
import UIKit

extension UIStoryboard {
    static var qiitaSearchViewController: QiitaSearchViewController {
        UIStoryboard(name: "QiitaSearch", bundle: nil).instantiateInitialViewController() as! QiitaSearchViewController
    }
}

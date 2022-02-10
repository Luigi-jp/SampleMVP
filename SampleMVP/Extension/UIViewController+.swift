//
//  UIViewController+.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/10.
//

import UIKit

extension UIViewController {
    func showError(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

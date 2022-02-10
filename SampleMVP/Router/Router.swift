//
//  Router.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/07.
//

import Foundation
import UIKit

class Router {
    static let shared = Router()
    private init() {}
    
    func showRoot(window: UIWindow) {
        let vc = UIStoryboard.qiitaSearchViewController
        let presenter = QiitaSearchPresenter(output: vc)
        vc.inject(with: presenter)
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    func showWeb(from: UIViewController, qiitaModel: QiitaModel) {
        let vc = UIStoryboard.webViewController
        let presenter = WebPresenter(output: vc, qiitaModel: qiitaModel)
        vc.inject(with: presenter)
        show(from: from, next: vc)
    }
}

extension Router {
    func show(from: UIViewController, next: UIViewController, animated: Bool = true) {
        if let nav = from.navigationController {
            nav.pushViewController(next, animated: animated)
        } else {
            from.modalPresentationStyle = .fullScreen
            from.present(next, animated: animated)
        }
    }
}

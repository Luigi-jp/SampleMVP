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
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}

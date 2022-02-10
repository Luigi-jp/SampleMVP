//
//  WebViewController.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/09.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {

    private var presenter: WebInput!

    @IBOutlet private weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidload()
    }

    func inject(with presenter: WebInput) {
        self.presenter = presenter
    }
}

extension WebViewController: WebOutput {
    func load(request: URLRequest) {
        webView.load(request)
    }
}

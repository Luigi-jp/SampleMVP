//
//  WebViewController.swift
//  SampleMVP
//
//  Created by 佐藤瑠偉史 on 2022/02/09.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    static func makeFromStoryboard(url: URL?) -> WebViewController {
        let vc = UIStoryboard.webViewController
        vc.url = url
        return vc
    }
    
    private var url: URL?

    @IBOutlet private weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = url else { return }
        webView.load(URLRequest(url: url))
    }
}

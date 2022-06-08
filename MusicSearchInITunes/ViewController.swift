//
//  ViewController.swift
//  MusicSearchInITunes
//
//  Created by Ibrahim Aitkazin on 08.06.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    var previewurl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: previewurl)!
        
        let urlreq = URLRequest(url: url)
        
        webview.load(urlreq)
    }

    
}


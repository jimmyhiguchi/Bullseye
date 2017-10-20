//
//  AboutTableViewController.swift
//  Bullseye
//
//  Created by Jimmy Higuchi on 10/18/17.
//  Copyright © 2017 Jimmy Higuchi. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBAction func closeAbout() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var webViewAbout: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webViewAbout.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
        
    }

    
}

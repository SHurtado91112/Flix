//
//  embedWebViewController.swift
//  Flix
//
//  Created by Steven Hurtado on 2/12/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import CircularSpinner

class embedWebViewController: UIViewController, UIWebViewDelegate
{

    var embedURL : String = ""
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        CircularSpinner.trackBgColor = UIColor.black
        CircularSpinner.trackPgColor = UIColor(red: 0.0/255.0,
                                               green:  122.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1)
        
        CircularSpinner.show("Grabbing trailer...", animated: true, type: .indeterminate)

        
        webView?.delegate = self
        webView.alpha = 0
        webView.allowsInlineMediaPlayback = true
        
        self.webView.loadRequest(URLRequest(url: URL(string: embedURL)!))
        
//        webView.loadHTMLString("<iframe width=\"\(webView.frame.width)\" height=\"\(webView.frame.height)\" src=\"\(embedURL)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        // Do any additional setup after loading the view.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        UIView.animate(withDuration: 0.4, animations:
            {
                webView.alpha = 1
                CircularSpinner.hide()
        }, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

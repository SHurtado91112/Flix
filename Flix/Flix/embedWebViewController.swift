//
//  embedWebViewController.swift
//  Flix
//
//  Created by Steven Hurtado on 2/12/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class embedWebViewController: UIViewController
{

    var embedURL : String = ""
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        webView.loadHTMLString("<iframe width=\"560\" height=\"315\" src=\"\(embedURL)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        // Do any additional setup after loading the view.
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

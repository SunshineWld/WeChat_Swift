//
//  WCQRCodeDetailViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/12/13.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCQRCodeDetailViewController: WCBaseViewController {
    
    var urlStr: String!
    var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let backItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(popViewController))
        self.navigationItem.leftBarButtonItem = backItem
        
        webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
        
        let url = URL.init(string: self.urlStr)
        let request = URLRequest.init(url: url!)
        webView.loadRequest(request)

    }
    func popViewController() {
        self.navigationController?.popToRootViewController(animated: true)
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

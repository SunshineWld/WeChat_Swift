//
//  WCPublishViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/23.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCPublishViewController: WCBaseViewController {
    
    var imageArr: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let cancelButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(sendItem))
        self.navigationItem.leftBarButtonItem = cancelButtonItem
        
        let sendButtonItem = UIBarButtonItem.init(title: "发送", style: UIBarButtonItemStyle.plain, target: self, action: #selector(sendItem))
        self.navigationItem.rightBarButtonItem = sendButtonItem
    }
    
//    func cancelItem() {
//        self.dismiss(animated: true, completion: nil)
//    }
    func sendItem() {
        self.dismiss(animated: true, completion: nil)
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

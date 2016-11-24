//
//  WCBaseTabBarController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/16.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addSubViewController()
        
        self.selectedIndex = 2
    }
    
    func addSubViewController() {
        
        let homeNav = WCHomeNavController(rootViewController: WCHomeViewController())
        homeNav.setTabBarTitleAndImage(titleStr: "微信", norImageStr: "tabbar_mainframe", selImageStr: "tabbar_mainframeHL")
        
        let contactNav = WCContactNavController(rootViewController: WCContactViewController())
        contactNav.setTabBarTitleAndImage(titleStr: "通讯录", norImageStr: "tabbar_contacts", selImageStr: "tabbar_contactsHL")
        
        let discoverNav = WCDiscoverNavController(rootViewController: WCDiscoverViewController())
        discoverNav.setTabBarTitleAndImage(titleStr: "发现", norImageStr: "tabbar_discover", selImageStr: "tabbar_discoverHL")
        
        let myNav = WCMyNavController(rootViewController: WCMyViewController())
        myNav.setTabBarTitleAndImage(titleStr: "我", norImageStr: "tabbar_me", selImageStr: "tabbar_meHL")
        
        self.viewControllers = [homeNav, contactNav, discoverNav, myNav]
        
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

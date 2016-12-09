//
//  WCBaseNavController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/16.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCBaseNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationBar.setBackgroundImage(UIImage.init(named: "Dimensional-_Code_Bg"), for: UIBarMetrics.default)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationBar.tintColor = UIColor.white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    func setTabBarTitleAndImage(titleStr: String, norImageStr: String, selImageStr: String) {
        self.tabBarItem.title = titleStr
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(red: 0.04, green: 0.73, blue: 0.03, alpha: 1.0) ], for: UIControlState.selected)
        var norImage = UIImage.init(named: norImageStr)
        var selImage = UIImage.init(named: selImageStr)
        
        norImage = norImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        selImage = selImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.tabBarItem.image = norImage
        self.tabBarItem.selectedImage = selImage
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

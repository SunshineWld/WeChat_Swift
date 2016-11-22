//
//  WCDiscoverViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/16.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCDiscoverViewController: WCBaseViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [[[String: String]]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "发现"
        tableView.delegate = self
        tableView.dataSource = self
        
        let filePath = Bundle.main.path(forResource: "WCDiscoverContents", ofType: "plist")
        dataSource = NSArray(contentsOfFile: filePath!) as! [[[String : String]]]

    }
    
    
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        let dic = dataSource[indexPath.section][indexPath.row]
        cell?.imageView?.image = UIImage(named: dic["icon"]!)
        cell?.textLabel?.text = dic["title"]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dic = dataSource[indexPath.section][indexPath.row]
        let className: String? = dic["target"]
        if className != nil {
            //由字符串转为类型时，如果类型是自定义的，需要在类型字符串前加上你的项目的名字
            let classVC = NSClassFromString("WeChat_Swift." + className!) as! WCBaseViewController.Type
            let targetVC: WCBaseViewController = classVC.init()
            targetVC.title = dic["title"]
            targetVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

}

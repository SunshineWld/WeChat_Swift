//
//  WCMyViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/16.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCMyViewController: WCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [[[String: String]]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我"
        self.setupTableView()
        self.setupDataSource()
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func setupDataSource() {
        let filePath = Bundle.main.path(forResource: "WCMyContents", ofType: "plist")
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
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellId)
        }
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        let dic = dataSource[indexPath.section][indexPath.row]
        cell?.textLabel?.text = dic["title"]
        cell?.detailTextLabel?.text = dic["details"]
        cell?.imageView?.image = UIImage(named: dic["icon"]!)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return 44
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let myInfoVC = WCMyInfoViewController()
            myInfoVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(myInfoVC, animated: true)
        }else if indexPath.section == 3 {
            let settingVC = WCSettingViewController()
            settingVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(settingVC, animated: true)
        }
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

//
//  WCPublishViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/23.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCPublishViewController: WCBaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var headerView: WCPublishHeaderView!
    var imageArr: [String]!
    var dataSource = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItem()
        self.setupTableView()
        
        
    }
    func setupNavigationItem() {
        let cancelButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(sendItem))
        self.navigationItem.leftBarButtonItem = cancelButtonItem
        
        let sendButtonItem = UIBarButtonItem.init(title: "发送", style: UIBarButtonItemStyle.plain, target: self, action: #selector(sendItem))
        self.navigationItem.rightBarButtonItem = sendButtonItem
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        dataSource = [["所在位置"],["谁可以看","提醒谁看"]]
        
        headerView = Bundle.main.loadNibNamed("WCPublishHeaderView", owner: self, options: nil)?.last as! WCPublishHeaderView
        headerView.imageArray = self.imageArr
        tableView.tableHeaderView = headerView
        headerView.layoutSubviews()
    }
    
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell?.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 19
    }
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

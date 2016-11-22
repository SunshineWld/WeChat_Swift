//
//  WCHomeViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/16.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

let cellIdentifier = String(describing: WCHomeViewCell.self)

class WCHomeViewController: WCBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataSource = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "微信"
        self.setupNavigationItem()
        self.setupTableView()
        self.setupDataSource()
        
    }

    func setupNavigationItem() {
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addAction))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        //注册单元格
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func setupDataSource() {
        
        for i in 0..<15 {
            let imageName = "image\(i)"
            let title = "titletitle\(i)"
            let subTitle = "subTitlesubTitlesubTitle\(i)"
            let dic = ["imageName":imageName, "title":title, "subTitle":subTitle]
            dataSource.append(dic)
        }
    }
    
    func addAction() {
        print("添加好友")
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WCHomeViewCell
        cell.updateCellWithDic(dic: dataSource[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let messageVC = WCMessageViewController()
        messageVC.title = dataSource[indexPath.row]["title"]
        messageVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(messageVC, animated: true)
        
        
    }
}

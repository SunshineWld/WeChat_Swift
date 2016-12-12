//
//  WCMyInfoViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/12/12.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCMyInfoViewController: WCBaseViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人信息"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        titleArray = [["头像", "名字", "微信号", "我的二维码", "我的地址"],
                      ["性别", "地区", "个性签名"]]
    }
    
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: WCMyInfoCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? WCMyInfoCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.last as? WCMyInfoCell
        }
        cell?.updateCellWithTitle(title: titleArray[indexPath.section][indexPath.row], value: "")
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
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

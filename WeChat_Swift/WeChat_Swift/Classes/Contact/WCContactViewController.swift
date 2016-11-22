//
//  WCContactViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/16.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height

class WCContactViewController: WCBaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating{

    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController! = nil
    
    var dataSource = [[String]]()
    var dataArr = [String]()
    var sectionArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "通讯录"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        
        let searchReultVC = WCSearchResultViewController()
        searchController = UISearchController.init(searchResultsController: searchReultVC)
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "搜索"
        searchController.dimsBackgroundDuringPresentation = true   //蒙层
        searchController.searchBar.setValue("取消", forKey: "_cancelButtonText");
       
//        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: width, height: 44)
        self.view.addSubview(searchController.searchBar)
        self.definesPresentationContext = true
        
        self.setupDataSource()
    }
    
    func setupDataSource() {
        dataSource = [ ["Adhi","Amoy","Aty"],
                       ["Bob","Bohu","Bftg"],
                       ["Ceny","Cindy","Centy", "Crg"],
                       ["Deny","Dindy","Drg"],
                       ["Feny","Findy","Fenty", "Frg"],
                       ["Geny","Gindy","Genty", "Grg"],
                       ["Heny","Henty", "Hrg"]]
        
        sectionArr = ["A", "B", "C", "D", "F", "G", "H"]
        
    }
    
    //MARK:UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell") 
        }
        cell?.imageView?.backgroundColor = UIColor.purple
        cell?.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        
        dataArr.append(dataSource[indexPath.section][indexPath.row])
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArr[section]
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionArr
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = WCUserInfoViewController()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.title = "详细资料"
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    //MARK:SearchResultUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
        var resultArr = [String]()
        
        let searchText = self.searchController.searchBar.text
        
        for item in dataArr {
            if item.contains(searchText!) {
                resultArr.append(item)
            }
        }
        
        let resultVC = self.searchController.searchResultsController as! WCSearchResultViewController
        resultVC.dataSource = resultArr
        
    }
    
    
    

}

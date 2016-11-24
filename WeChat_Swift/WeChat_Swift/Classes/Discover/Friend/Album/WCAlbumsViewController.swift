//
//  WCAlbumsViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/23.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCAlbumsViewController: WCBaseViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "相册"
        let cancelButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelItem))
        self.navigationItem.rightBarButtonItem = cancelButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        
        self.pushPhotosViewController(animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "第\(indexPath.row+1)个相册"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.pushPhotosViewController(animated: true)
    }
    
    func pushPhotosViewController(animated: Bool) {
        let photosVC = WCPhotosViewController()
        self.navigationController?.pushViewController(photosVC, animated: animated)
    }
    
    func cancelItem() {
        self.dismiss(animated: true, completion: nil)
    }

    

}

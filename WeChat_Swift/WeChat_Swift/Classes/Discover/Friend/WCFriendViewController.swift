//
//  WCFriendViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/17.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCFriendViewController: WCBaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var headerView: WCFriendHeaderView!
    
    var activityView: UIImageView!
    var containerView: UIView!
    var dragging: Bool = false
    var num: Int = 0
    var currentY: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let rightItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(cameraAction))
        self.navigationItem.rightBarButtonItem = rightItem
        
        
        tableView.backgroundColor = UIColor.black
        tableView.delegate = self;
        tableView.dataSource = self;
        
        headerView = Bundle.main.loadNibNamed("WCFriendHeaderView", owner: self, options: nil)?.last as! WCFriendHeaderView
        tableView.tableHeaderView = headerView
        
//        self.setupActivityView()
    }
    
    func setupActivityView() {
        
        let actImage = UIImage(named: "activity")
        activityView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        activityView.image = actImage
        activityView.layer.cornerRadius = 15
        activityView.layer.masksToBounds = true
        
        containerView = UIView(frame: CGRect(x: 15, y: 120, width: 30, height: 30))
        containerView.backgroundColor = UIColor.orange
        containerView.addSubview(activityView)
       
        tableView.contentInset = UIEdgeInsetsMake(-150, 0, 0, 0)
        self.view.addSubview(containerView)
    }
    
    //MARK:Action
    func cameraAction() {
        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let photos = UIAlertAction.init(title: "相册", style: UIAlertActionStyle.default) { (alertAction) in
            print(alertAction.title)
            
            let discoverNav = WCBaseNavController(rootViewController: WCAlbumsViewController())
            self.present(discoverNav, animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (alertAction) in
            print(alertAction.title)
        }
        
        actionSheet.addAction(photos)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }

    //MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "第\(indexPath.row)行"
        return cell!
    }
    
    //MARK:UIScrollViewDegelate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dragging = true
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if num == 0 {
            num += 1
            return
        }
        let offsetY = scrollView.contentOffset.y
        let angle = -offsetY * CGFloat(M_PI) / 30
        if dragging {
            if offsetY <= 110 {
                containerView.frame.origin.y = 10 + offsetY
            }
        }else {
            if currentY < 120 {
                containerView.frame.origin.y = 10 + offsetY
            }
        }
        activityView.transform = CGAffineTransform.init(rotationAngle: angle)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.25) { 
            self.containerView.frame = CGRect(x: 15, y: 120, width: 30, height: 30)
            self.activityView.transform = CGAffineTransform.init(rotationAngle: 2*CGFloat(M_PI))
        }
    }

    
}

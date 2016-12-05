//
//  WCAlertSheet.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/28.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCAlertSheetCell: UITableViewCell {
    var titleLabel: UILabel!
    var title: String! {
        willSet {
            self.title = newValue
        }
        didSet {
            titleLabel.text = self.title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        titleLabel = UILabel(forAutoLayout: ())
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.black
        self.contentView.addSubview(titleLabel)
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
    }
    
    static func cellWithTableView(tableView: UITableView) -> WCAlertSheetCell{
        let identifier = "WCAlertSheetCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = WCAlertSheetCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        return cell as! WCAlertSheetCell
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.contentView.backgroundColor = HexColor(0xf8f8f8)
        }else {
            self.contentView.backgroundColor = HexColor(0xffffff)
        }
    }
    
}

class WCAlertSheet: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var bgView: UILabel!
    var tableView: UITableView!
    var cancelButtonTitle: String!
    var dataSource = [String]()
    
    var completeClosure: ((Int) -> Void)!
    
    //自定义头部
    var header: UIView {
        set{
            self.header = newValue
            self.tableView.tableHeaderView = self.header
        }
        get {
            return self.header
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        cancelButtonTitle = "取消"

        bgView = UILabel(forAutoLayout: ())
        bgView.backgroundColor = UIColor.black
        bgView.isUserInteractionEnabled = true
        self.addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        tableView = UITableView(forAutoLayout: ())
        tableView.backgroundColor = UIColor.clear
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = HexColor(0x535353)
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        tableView.autoSetDimension(ALDimension.height, toSize: 130)
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: ALEdge.top)
        
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(disappear))
        singleTap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(singleTap)
        
    }
    
    func disappear() {
        self.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 1))
    }
    
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            return 4
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataSource.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WCAlertSheetCell = WCAlertSheetCell.cellWithTableView(tableView: tableView)
        if indexPath.section == 0 {
            cell.title = dataSource[indexPath.row]
        }else {
            cell.title = cancelButtonTitle
        }
        cell.backgroundColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            self.clickedIndex(index: indexPath.row + 1)
        }else{
            self.clickedIndex(index: 0)
        }
    }
    
    func clickedIndex(index: Int) {
        completeClosure(index)
        
        let tableHeight = tableView.bounds.size.height
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.bgView.alpha = 0
            self.tableView.autoPinEdge(toSuperviewEdge: ALEdge.bottom, withInset: -tableHeight)
            self.layoutIfNeeded()
        }, completion: { (finished: Bool) -> Void in
            self.completeClosure = nil
            self.removeFromSuperview()
        })
    }
    
    //MARK: 初始化标题内容
    static func initWithOtherButtonTitle(otherButtonTitleArray: [String]) -> WCAlertSheet{
       return self.initWithTitle(title: nil, cancelButtonTitle: "取消", otherButtonTitleArray: otherButtonTitleArray)
    }
    static func initWithCancelButtonTitle(cancelButtonTitle: String, otherButtonTitleArray: [String]) -> WCAlertSheet{
        return self.initWithTitle(title: nil, cancelButtonTitle: cancelButtonTitle, otherButtonTitleArray: otherButtonTitleArray)
    }
    static func initWithTitle(title: String?, cancelButtonTitle: String, otherButtonTitleArray: [String]) -> WCAlertSheet{
        let alertSheet = WCAlertSheet(frame: SCREEN_BOUNDS)
        if !(cancelButtonTitle.isEmpty) {
            alertSheet.cancelButtonTitle = cancelButtonTitle
        }
        alertSheet.dataSource = otherButtonTitleArray
        return alertSheet
    }
    
    func showWithCompletionBlock(completionBlock:@escaping (_ buttonIndex: Int) -> Void) {
        completeClosure = completionBlock
        
        let topMostWindow = UIApplication.shared.windows.first
        topMostWindow?.addSubview(self)
        self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        var tableHeight = self.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0)) * CGFloat(dataSource.count + 1)
        tableHeight += self.tableView(tableView, heightForHeaderInSection: 0) * CGFloat(self.numberOfSections(in: tableView))
        if (tableView.tableHeaderView != nil) {
            tableHeight += (tableView.tableHeaderView?.frame.size.height)!
        }
        tableView.autoSetDimension(ALDimension.height, toSize: tableHeight)
        bgView.alpha = 0
        tableView.autoPinEdge(toSuperviewEdge: ALEdge.bottom, withInset: -tableHeight)
        self.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.bgView.alpha = 0.35
            self.tableView.autoPinEdge(toSuperviewEdge: ALEdge.bottom, withInset: 0)
            self.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    deinit {
        print("\(NSStringFromClass(self.classForCoder)) deinit")
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
}

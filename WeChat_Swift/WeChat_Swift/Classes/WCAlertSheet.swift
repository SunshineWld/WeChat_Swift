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
        titleLabel = UILabel(frame: self.contentView.bounds)
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.black
        self.contentView.addSubview(titleLabel)
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

class WCAlertSheet: UIView {
    
    var bgView: UILabel!
    var tableView: UITableView!
    var cancelButtonTitle: String!
    var dataSource: [Any]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        cancelButtonTitle = "取消"
        bgView = UILabel(frame: self.bounds)
        bgView.backgroundColor = RGBCOLOR(0, 0, 0.45)
        
       
    }

}

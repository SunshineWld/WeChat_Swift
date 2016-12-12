//
//  WCMyInfoCell.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/12/12.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCMyInfoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detaillabel: UILabel!
    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var accessory: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headImgView.layer.cornerRadius = 5
        headImgView.layer.masksToBounds = true
    }
    
    func updateCellWithTitle(title: String, value: String) {
        if title == "头像" {
            headImgView.alpha = 1
            detaillabel.alpha = 0
            accessory.alpha = 1
            titleLabel.text = "头像"
            
        }else if title == "微信号"{
            headImgView.alpha = 0
            detaillabel.alpha = 1
            accessory.alpha = 0
            
        }else {
            headImgView.alpha = 0
            detaillabel.alpha = 1
            accessory.alpha = 1
        }
        
        titleLabel.text = title
        detaillabel.text = value.length > 0 ? value : "未填写"
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

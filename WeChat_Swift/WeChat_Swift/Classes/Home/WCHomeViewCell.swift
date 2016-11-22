//
//  WCHomeViewCell.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/16.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCHomeViewCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        iconView.layer.cornerRadius = 5
        iconView.layer.masksToBounds = true
        
    }
    
    func updateCellWithDic(dic: [String: String]) {
        iconView.image = UIImage.init(named: dic["imageName"]!)
        titleLabel.text = dic["title"]
        subTitleLabel.text = dic["subTitle"]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.contentView.backgroundColor = UIColor.lightGray
        }else {
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            self.contentView.backgroundColor = UIColor.lightGray
        }else {
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
    
}

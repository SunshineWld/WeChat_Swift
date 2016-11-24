//
//  WCFriendHeaderView.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/21.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCFriendHeaderView: UIView {
    
    @IBOutlet weak var bgButton: UIButton!
    @IBOutlet weak var headButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        headButton.layer.borderColor = UIColor.white.cgColor
        headButton.layer.borderWidth = 1.0
        
    }
    
    @IBAction func bgButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func headButtonAction(_ sender: UIButton) {
    }
    
    
    
}

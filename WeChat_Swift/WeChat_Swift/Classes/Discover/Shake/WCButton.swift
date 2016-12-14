//
//  WCButton.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/12/14.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: (self.width-(self.imageView?.image?.size.width)!)*0.5, y: 0, width: (self.imageView?.image?.size.width)!, height: (self.imageView?.image?.size.height)!)
        self.titleLabel?.frame = CGRect(x: 0, y: (self.imageView?.bottom)!, width: self.width, height: self.height-(self.imageView?.bottom)!)
    }

}

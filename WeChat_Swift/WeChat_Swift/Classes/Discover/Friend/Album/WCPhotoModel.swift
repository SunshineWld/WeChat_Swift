//
//  WCPhotoModel.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/23.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCPhotoModel: NSObject {
    
    var icon: String?
    var btnImage: String?
    var clickedBtn: Bool = false
    
    func setValueWithDict(dict: [String: Any]) -> Any {
        self.setValuesForKeys(dict)
        return self
    }
    
    static func initWithDict(dict: [String: Any]) -> Any {
        return WCPhotoModel().setValueWithDict(dict: dict)
    }

}

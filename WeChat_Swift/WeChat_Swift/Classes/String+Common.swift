//
//  String+Common.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/12/6.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

extension String {
    
    //计算字符串的长度
    var length: Int {
        return self.characters.count
    }
    
    //根据下标返回字符
    func characterAtIndex(index: Int) -> Character{
        var charArray = [Character]()
        for char in self.characters {
            charArray.append(char)
        }
        return charArray[index]
    }
    
    //验证邮箱格式
    func isValidateEmail() -> Bool {
        let stricterFilter = true  //规定是否严格判断格式
        
        let stricterFilterString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let laxString = ".+@.+\\.[A-Za-z]{2}[A-Za-z]*"
        let emailRegex = stricterFilter ? stricterFilterString : laxString
        
        let emailCheck = NSPredicate(format: "SELF MATCHES \(emailRegex)")
        
        return emailCheck.evaluate(with: self)
    }
    
    //是否是整形数字
    func isPureInt() -> Bool {
        let scan = Scanner(string: self)
        let val: UnsafeMutablePointer<Int>? = nil
        return scan.scanInt(val) && scan.isAtEnd
    }
    //验证身份证号码
    func isValidateIDCard() -> Bool {
        if self.length != 18 {
            return false
        }
        let codeArray = ["7","9","10","5","8","4","2","1","6","3","7","9","10","5","8","4","2"]
        let checkCodeDic = ["0": "1", "1": "0", "2": "X", "3": "9", "4": "8",
                            "5": "7", "6": "6", "7": "5", "8": "4", "9": "3", "10": "2"]
        let subIndex = self.index(before: self.endIndex)
        let scan = Scanner(string: self.substring(to: subIndex))
        
        let val: UnsafeMutablePointer<Int>? = nil
        let isNum = scan.scanInt(val) && scan.isAtEnd
        if !isNum {
            return false
        }
        var sumValue: Int = 0
        for i in 0..<17 {
            let num = Int((self as NSString).substring(with: NSMakeRange(i, 1)))! * Int(codeArray[i])!
            sumValue += num
        }
        let strlast = checkCodeDic[String(sumValue%11)]
        if strlast == (self as NSString).substring(with: NSMakeRange(17, 1)) {
            return true
        }
        return false
        
    }
    
    //验证手机号码
    func isValidateMobileNumber() -> Bool {
        //手机号以13，15，18开头，8个 \d 数字字符 (新增14 17 号段)
        let phoneRegex = "^((13[0-9])|(14[5,7])|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES \(phoneRegex)")
        
        return phoneTest.evaluate(with: self)
    }
    
    //是否是网址
    func isValidateWebUrl() -> Bool {
        let webRegex = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        let webTest = NSPredicate(format: "SELF MATCHES \(webRegex)")
        
        return webTest.evaluate(with: self)
    }
    
    
    //验证固定电话 座机
    func isValidateLandlineTelephone() -> Bool {
        let regex = "^(0[0-9]{2,3})?([2-9][0-9]{6,7})+([0-9]{1,4})?$"
        let phoneTest = NSPredicate(format: "SELF MATCHES \(regex)")
        
        return phoneTest.evaluate(with: self)
    }
    
    //包含中文字符
    func containsChineseCharacter() -> Bool{
        var isContan = false
        for i in 0..<self.length {
            let range = NSMakeRange(i, 1)
            let subString = (self as NSString).substring(with: range)
            let cString = (subString as NSString).utf8String
            if (cString != nil) && strlen(cString) == 3 {
                isContan = true
            }
        }
        return isContan
    }
    
    func stringHeightWithFont(font: UIFont, width: Float) -> Float{
        if self.characters.count == 0 {
            return 0
        }
        let copyString = "\(self)" as NSString
        var size = CGSize.zero
        let constrainedSize = CGSize(width: CGFloat(width), height: CGFloat.greatestFiniteMagnitude)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = NSLineBreakMode.byWordWrapping
        size = copyString.boundingRect(with: constrainedSize,
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraph], context: nil).size
        return Float(size.height+0.5)
    }
    
    func stringWidthWithFont(font: UIFont, height: Float) -> Float{
        if self.characters.count == 0 {
            return 0
        }
        let copyString = "\(self)" as NSString
        var size = CGSize.zero
        let constrainedSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat(height))
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = NSLineBreakMode.byWordWrapping
        size = copyString.boundingRect(with: constrainedSize,
                                       options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                       attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraph], context: nil).size
        return Float(size.width+0.5)
    }
    
}



//
//  WCConfig.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/28.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

let KeyboardAnimationDuration = 0.25

let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_PHONE  =    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
let IS_IPHONE_4   =  (IS_PHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5   =  (IS_PHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6   =  (IS_PHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6P  =  (IS_PHONE && SCREEN_MAX_LENGTH == 736.0)

let ScreenScale   =  UIScreen.main.scale
let userDefaults  =  UserDefaults.standard
let keyWindow     =  UIApplication.shared.delegate?.window
let WindowZoomScale = SCREEN_WIDTH / 320.0
let UniversalZoomScale = min(1.8, WindowZoomScale)    //适配iPad

let XcodeBundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"]
let XcodeAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]

//获取Document文件夹的路径
let DocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
//获取自定义文件的bundle路径
let ResourcePath = Bundle.main.resourcePath

//通用色调的色值
let KY_TINT_COLOR = HexColor(0xf9be00)   //纯黄色
let KY_TINT_HIGHLIGHT_COLOR = HexColor(0xc89105)  //纯黄色  高亮效果


//RGB进制颜色值
func RGBCOLOR(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}
//RGBA进制颜色值
func RGBACOLOR(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
//16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000
func HexColor(_ hexValue: UInt) -> UIColor {
    return UIColor(red: CGFloat((((hexValue) & 0xFF0000) >> 16))/255.0, green: CGFloat((((hexValue) & 0xFF00) >> 8))/255.0, blue: CGFloat(((hexValue) & 0xFF))/255.0, alpha: 1.0)
}



//
//  UIView+Addition.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/29.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

extension UIView {
    
    //left
    var left: CGFloat {
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.x
        }
    }
    
    //right
    var right: CGFloat {
        set{
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    //top
    var top: CGFloat {
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.y
        }
    }
    
    //bottom
    var bottom: CGFloat {
        set{
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    //centerX
    var centerX: CGFloat {
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
        get {
            return self.center.x
        }
    }
    
    //centerY
    var centerY: CGFloat {
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
        get {
            return self.center.y
        }
    }
    
    //width 
    var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    //height
    var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    //origin
    var origin: CGPoint {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    
    //size 
    var size: CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    func removeAllSubViews() {
        while self.subviews.count > 0 {
            let child = self.subviews.last
            child?.removeFromSuperview()
        }
    }
    
    //获取父控制器
    func nearsetViewController() -> UIViewController? {
        var next = self.next
        while (next != nil) {
            if (next?.isKind(of: UIViewController.classForCoder()))! {
                return next as? UIViewController
            }
            next = next?.next
        }
        return nil
    }
    
    
}

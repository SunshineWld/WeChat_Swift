//
//  WCAlertView.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/30.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

let MsgLabelWidth = 210*WindowZoomScale

extension WCAlertView {
    
}

class WCAlertView: UIView {
    
    var bgView: UILabel!
    var btnView: UIView!
    var messageView: UIView!
    var btnCount: Int = 0
    
    var messageLabel: UILabel!
    var contentView: UIView!
    var cancelButtonTitle: String = "取消"
    var dataSource = [NSString]()
    var viewArray = [Any]()
    
    var completeClosures: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.clear
        bgView = UILabel(forAutoLayout: ())
        bgView.backgroundColor = RGBACOLOR(0, 0, 0, 0.6)
        bgView.isUserInteractionEnabled = true
        self.addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        contentView = UIView(forAutoLayout: ())
        contentView.backgroundColor = UIColor.clear
        contentView.autoSetDimensions(to: CGSize(width: 245*WindowZoomScale, height: 162*WindowZoomScale))
        self.addSubview(contentView)
        contentView.autoAlignAxis(toSuperviewAxis: ALAxis.vertical)
        contentView.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        
        messageView = UIView(forAutoLayout: ())
        messageView.backgroundColor = UIColor.white
        messageView.layer.cornerRadius = 7*WindowZoomScale
        messageView.layer.masksToBounds = true
        contentView.addSubview(messageView)
        messageView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: ALEdge.bottom)
        messageView.autoSetDimension(ALDimension.height, toSize: 120*WindowZoomScale)
        
        messageLabel = UILabel(forAutoLayout: ())
        messageLabel.numberOfLines = 3
        messageLabel.font = UIFont.boldSystemFont(ofSize: 15)
        messageView.addSubview(messageLabel)
        messageLabel.autoAlignAxis(toSuperviewAxis: ALAxis.vertical)
        messageLabel.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        messageLabel.autoSetDimensions(to: CGSize(width: MsgLabelWidth, height: 120*WindowZoomScale))
        
        btnView = UIView(forAutoLayout: ())
        
        
        
    }
    
    

}

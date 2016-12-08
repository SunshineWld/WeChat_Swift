//
//  WCAlertView.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/30.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

let MsgLabelWidth = 210*WindowZoomScale

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
        btnView.backgroundColor = UIColor.clear
        contentView.addSubview(btnView)
        btnView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: ALEdge.top)
        btnView.autoSetDimension(ALDimension.height, toSize: 35*WindowZoomScale)
    }
    
    //MARK:初始化标题内容
    static func initWithMessage(message: String) -> WCAlertView {
        return self.initWithTitle(title: nil, message: message, cancelButtonTitle: "确定", otherButtonTitle: nil)
    }
    
    static func initWithTitle(title: String, message:String) -> WCAlertView{
        return self.initWithTitle(title: title, message: message, cancelButtonTitle: "确定", otherButtonTitle: nil)
    }

    static func initWithTitle(title: String, message: String, cancelButtonTitle: String) -> WCAlertView{
        return self.initWithTitle(title: title, message: message, cancelButtonTitle: cancelButtonTitle, otherButtonTitle: nil)
    }
    
    static func initWithTitle(title: String?, message: String, cancelButtonTitle: String, otherButtonTitle: [String]?) -> WCAlertView{
        let alertView = WCAlertView.init(frame: SCREEN_BOUNDS)
        
        if message.characters.count > 0 {
            if title != nil {
                var titleFontSize = 16.0
                let titleFont = UIFont.systemFont(ofSize: CGFloat(titleFontSize))
                var titleWidth = title?.stringWidthWithFont(font: titleFont, height: Float(titleFontSize))
                
                //title只能显示一行
                while CGFloat(titleWidth!) > MsgLabelWidth {
                    titleFontSize = titleFontSize - 1;
                    titleWidth = title?.stringWidth(with: UIFont.systemFont(ofSize: CGFloat(titleFontSize)), height: Float(titleFontSize))
                }
                
                let mutableAttriString = NSMutableAttributedString.init()
                let titleAttributeString = self.attributedString(string: title!,
                                                                 fontSize: CGFloat(titleFontSize),
                                                                 lineSpacing: 8.0)
                mutableAttriString.append(titleAttributeString)
                
                let msgAttributeString = self.attributedString(string: "\n\(message)",
                                                               fontSize: 13,
                                                               lineSpacing: 3)
                mutableAttriString.append(msgAttributeString)
                
                alertView.messageLabel.attributedText = mutableAttriString;
            }else {
                let msgAttributeString = self.attributedString(string: message,
                                                               fontSize: 14,
                                                               lineSpacing: 8)
                alertView.messageLabel.attributedText = msgAttributeString
            }
        }
        var dataSource = [String]()
        if otherButtonTitle != nil {
            dataSource += otherButtonTitle!
        }
        dataSource.insert(cancelButtonTitle, at: 0)
        alertView.createButton(dataSource: dataSource)
        
        return alertView
    }
    
    static func attributedString(string: String, fontSize: CGFloat, lineSpacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize),
                          NSParagraphStyleAttributeName: paragraphStyle] as [String : Any]
        let attributeString = NSAttributedString.init(string: string, attributes: attributes)
        return attributeString
    }
    
    func createButton(dataSource: [String]) {
        btnCount = dataSource.count
        
        var viewArray = [UIView]()
        for i in 0...(dataSource.count-1) {
            let view = UIView(forAutoLayout: ())
            btnView.addSubview(view!)
            
            let btnStr = dataSource[dataSource.count - i - 1]
            
            let button = UIButton(type: UIButtonType.custom)
            button.tag = dataSource.count - i
            button.setTitleColor(UIColor.black, for: UIControlState.normal)
            button.setTitle(btnStr as String, for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.addTarget(self, action: #selector(clickBtn(btn:)), for: UIControlEvents.touchUpInside)
            button.addTarget(self, action: #selector(removeColor(button:)), for: UIControlEvents.touchUpOutside)
            button.addTarget(self, action: #selector(exchangeColor(button:)), for: UIControlEvents.touchDown)
            view?.addSubview(button)
            
            if dataSource.count == 1 {
                button.backgroundColor = KY_TINT_COLOR
            }else{
                if i>0 {
                    button.backgroundColor = HexColor(0xd7d7d7)
                }else{
                    button.backgroundColor = KY_TINT_COLOR
                }
            }
            button.layer.cornerRadius = 7 * WindowZoomScale
            button.layer.masksToBounds = true
            button.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
            
            viewArray.append(view!)
        }
        
        for i in 0..<viewArray.count {
            viewArray[i].autoPinEdge(toSuperviewEdge: ALEdge.top, withInset: 0)
            viewArray[i].autoPinEdge(toSuperviewEdge: ALEdge.bottom, withInset: 0)
            if i < viewArray.count - 1 {
                viewArray[i].autoPinEdge(ALEdge.left, to: ALEdge.right, of: viewArray[i+1])
                viewArray[i].autoPinEdge(ALEdge.left, to: ALEdge.right, of: viewArray[i+1], withOffset: 5*WindowZoomScale)
            }
        }
        viewArray[0].autoPinEdge(toSuperviewEdge: ALEdge.right, withInset: 0)
        viewArray[viewArray.count - 1].autoPinEdge(toSuperviewEdge: ALEdge.left, withInset: 0)
        if viewArray.count > 1 {
            (viewArray as NSArray).autoMatchViewsDimension(ALDimension.width)
        }
        
    }
    
    func exchangeColor(button: UIButton) {
        if button.isHighlighted {
            if btnCount == 1 {
                button.backgroundColor = KY_TINT_HIGHLIGHT_COLOR
            }else{
                if button.tag < btnCount {
                    button.backgroundColor = HexColor(0xb3b3b3)
                }else{
                    button.backgroundColor = KY_TINT_HIGHLIGHT_COLOR
                }
            }
        }
    }
    
    func removeColor(button: UIButton) {
        
        if btnCount == 1 {
            button.backgroundColor = KY_TINT_COLOR
        }else{
            if button.tag < btnCount {
                button.backgroundColor = HexColor(0xd7d7d7)
            }else{
                button.backgroundColor = KY_TINT_COLOR
            }
        }
    }

    func clickBtn(btn: UIButton) {
        self.clickedIndex(index: btn.tag - 1)
    }
    
    func clickedIndex(index: Int) {
        if completeClosures != nil {
            completeClosures!(index)
        }
        
        UIView.animate(withDuration: 0.25, animations:{
            self.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.bgView.backgroundColor = UIColor.clear
            self.contentView.alpha = 0
        }, completion: { (finished: Bool) -> Void in
            self.completeClosures = nil
            self.removeFromSuperview()
        })
    }
    
    func showWithCompletionBlock(completionBlock:((_ buttonIndex: Int) -> Void)? = nil) {
        completeClosures = completionBlock
        
        let topMostWindow = UIApplication.shared.windows.first
        topMostWindow?.addSubview(self)
        self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        self.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.bgView.alpha = 0
        self.contentView.alpha = 0.5
        
        UIView.animate(withDuration: 0.25, animations:{
            self.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.contentView.alpha = 1
            self.bgView.alpha = 1
        })
    }
    
    deinit {
        print("\(NSStringFromClass(self.classForCoder)) deinit")
    }
    

    
    
    
}

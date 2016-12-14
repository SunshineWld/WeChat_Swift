//
//  WCShakeViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/17.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

class WCShakeViewController: WCBaseViewController {
    
    var upImageView: UIImageView!
    var downImageView: UIImageView!
    var upLine: UIImageView!
    var downLine: UIImageView!
    var searchView: UIView!
    var selectedBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.16, green: 0.18, blue: 0.18, alpha: 1.0)
        
        self.setupBgView()
        self.setupBottomButton()
        self.setupShakeView()
        
    }
    
    func setupBgView() {
        let imageView = UIImageView(frame: CGRect(x: (SCREEN_WIDTH-320)*0.5, y: (SCREEN_HEIGHT*0.5-320*0.5-50), width: 320, height: 320))
        imageView.image = UIImage(named: "ShakeHideImg_women")
        self.view.addSubview(imageView)
    }
    func setupBottomButton() {
        let titleArray = ["人", "歌曲", "电视"]
        let normalImages = ["Shake_icon_people", "Shake_icon_music", "Shake_icon_tv"]
        let selectedImages = ["Shake_icon_peopleHL", "Shake_icon_musicHL", "Shake_icon_tvHL"]
        
        let btnWidth: CGFloat = 80
        let btnHeight: CGFloat = 60
        let margin = (SCREEN_WIDTH - 3*btnWidth) / 4
        
        let bottomView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT-btnHeight-64-20, width: SCREEN_WIDTH, height: btnHeight+20))
        bottomView.backgroundColor = UIColor.clear
        self.view.addSubview(bottomView)
        
        for i in 0..<titleArray.count {
            let button = WCButton()
            button.frame = CGRect(x: margin + ((btnWidth+margin) * CGFloat(i)), y: 0, width: btnWidth, height: btnHeight)

            button.setTitle(titleArray[i], for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.titleLabel?.textAlignment = NSTextAlignment.center
            button.setTitleColor(UIColor.white, for: UIControlState.normal)
            button.setTitleColor(UIColor.green, for: UIControlState.selected)
            
            button.setImage(UIImage(named: normalImages[i]), for: UIControlState.normal)
            button.setImage(UIImage(named: selectedImages[i]), for: UIControlState.selected)
            
            button.addTarget(self, action: #selector(buttonClick(btn:)), for: UIControlEvents.touchUpInside)

            if i == 0 {
                button.isSelected = true
                self.selectedBtn = button
            }
            bottomView.addSubview(button)
        }
    }
    func setupShakeView() {
        let upImage = UIImage(named: "Shake_Logo_Up")
        let upImageView = UIImageView(image: upImage)
        upImageView.frame = CGRect(x: (SCREEN_WIDTH-(upImage?.size.width)!)*0.5, y: (SCREEN_HEIGHT*0.5-64-(upImage?.size.height)!), width: (upImage?.size.width)!, height: (upImage?.size.height)!)
        self.view.addSubview(upImageView)
        self.upImageView = upImageView
        
        let downImage = UIImage(named: "Shake_Logo_Down")
        let downImageView = UIImageView(image: downImage)
        downImageView.frame = CGRect(x: (SCREEN_WIDTH-(downImage?.size.width)!)*0.5, y: upImageView.bottom, width: (downImage?.size.width)!, height: (downImage?.size.height)!)
        self.view.addSubview(downImageView)
        self.downImageView = downImageView
        
        let upLine = UIImageView(image: UIImage(named: "Shake_Line_Up"))
        upLine.frame = CGRect(x: 0, y: upImageView.bottom, width: SCREEN_WIDTH, height: 5)
        upLine.isHidden = true
        
        let downLine = UIImageView(image: UIImage(named: "Shake_Line_Down"))
        downLine.frame = CGRect(x: 0, y: downImageView.top-5, width: SCREEN_WIDTH, height: 5)
        downLine.isHidden = true
        
        self.view.addSubview(upLine)
        self.view.addSubview(downLine)
        self.upLine = upLine
        self.downLine = downLine
        
    }
    
    func buttonClick(btn: WCButton) {
        self.selectedBtn.isSelected = false
        btn.isSelected = true
        self.selectedBtn = btn
    }
    
    //实现摇一摇功能
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        self.upLine.isHidden = false
        self.downLine.isHidden = false
        
        UIView.animate(withDuration: 0.6, animations: {
            
            self.upImageView.top -= 60
            self.upLine.top -= 60
            self.downImageView.top += 60
            self.downLine.top += 60
            
        }) { (finish: Bool) -> Void in
            
            UIView.animate(withDuration: 0.6, animations: {
                
                self.upImageView.top += 60
                self.upLine.top += 60
                self.downImageView.top -= 60
                self.downLine.top -= 60
                
            }, completion: { (finish: Bool) -> Void in
                
                self.upLine.isHidden = true
                self.downLine.isHidden = true
                
                //搜索
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

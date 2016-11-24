//
//  WCPhotoCell.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/23.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

protocol WCPhotoCellDelegate {
    func photoCell(cell: WCPhotoCell, btn: UIButton)
}

class WCPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var checkBtn: UIButton!
    
    var delegate: WCPhotoCellDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func updateCellWithModel(model: WCPhotoModel) {
        imageView.image = UIImage(named: model.icon!)
        checkBtn.isSelected = model.clickedBtn
    }

    func updateCellWithDic(dic: [NSString: Any]) {

        imageView.image = UIImage.init(named: dic["icon"] as! String)
        checkBtn.isSelected = dic["clickedBtn"] as! Bool
        
    }
    @IBAction func checkBtnAction(_ sender: UIButton) {
        
        self.delegate?.photoCell(cell: self, btn: sender)
        
    }
}

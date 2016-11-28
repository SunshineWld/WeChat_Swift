//
//  WCPublishHeaderView.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/24.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

let itemWidth = (SCREEN_WIDTH-20-3*(space+1)) / 4.0

class WCPublishHeaderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    weak var publishVC = WCPublishViewController()
    
    var imageArray: [String]! {
        willSet(newValue) {
            self.imageArray = newValue
        }
        didSet {
            if self.imageArray.count <= 8 {
                self.imageArray.append("AlbumAddBtn")
            }
            self.imgCollectionView.reloadData()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var row: CGFloat = 0
        if self.imageArray.count > 8 {
            row = 3
        }else if self.imageArray.count > 4 {
            row = 2
        }else {
            row = 1
        }
        
        imgCollectionView.frame.size.height = itemWidth*row + (row-1)*(space+1)
        self.frame.size.height = 108+10+10+imgCollectionView.frame.size.height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        textView.textContainer.lineFragmentPadding = 0
        textView.text = "这一刻的想法..."
        textView.textColor = UIColor.lightGray
        textView.delegate = self
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.minimumLineSpacing = space+1
        flowLayout.minimumInteritemSpacing = space+1

        imgCollectionView.delegate = self
        imgCollectionView.dataSource = self
        imgCollectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "imgCollectionCell")
        
        imgCollectionView.frame.size.height = itemWidth
        self.frame.size.height = 108+10+10+imgCollectionView.frame.size.height
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCollectionCell", for: indexPath)

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
        imageView.contentMode = UIViewContentMode.scaleToFill
        cell.contentView.addSubview(imageView)
        
        imageView.image = UIImage(named: self.imageArray[indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if imageArray[indexPath.item] == "AlbumAddBtn" {
            print("添加照片")
            
        }
    }
    
    //MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.black
    }

}

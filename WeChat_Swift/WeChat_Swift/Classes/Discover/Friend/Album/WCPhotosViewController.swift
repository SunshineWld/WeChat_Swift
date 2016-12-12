//
//  WCPhotosViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/22.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit

let space: CGFloat = 5.0
let minItemSize: CGFloat = 80.0

class WCPhotosViewController: WCBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, WCPhotoCellDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    var fromPublishVC: Bool = false
    
    var selectCell = [WCPhotoCell]()
    var dataSource = [WCPhotoModel]()
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "相机胶卷"
        
        let cancelButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelItem))
        self.navigationItem.rightBarButtonItem = cancelButtonItem
        
        self.setupBottomView()

        self.setupDataSource()

        self.setupCollectionView()
    }
    
    func setupBottomView() {
        
        bottomView.layer.borderColor = UIColor.lightGray.cgColor
        bottomView.layer.borderWidth = 0.5

        numLabel.alpha = 0
        numLabel.layer.cornerRadius = 10
        numLabel.layer.masksToBounds = true
        previewBtn.isEnabled = false
        doneBtn.isEnabled = false
        
    }
    
    func setupCollectionView() {
        
        let itemSizeWidth = (SCREEN_WIDTH-10 - 3*space) / 4.0
        flowLayout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeWidth)
        flowLayout.minimumLineSpacing = CGFloat(space)
        flowLayout.minimumInteritemSpacing = CGFloat(space)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        //注册单元格
        collectionView.register(UINib.init(nibName: String(describing: WCPhotoCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: WCPhotoCell.self))
    }
    
    func setupDataSource() {
        let path = Bundle.main.path(forResource: "PictureCell", ofType: "plist")
        let dataArr = NSArray(contentsOfFile: path!) as! [[String : Any]]
        for dict in dataArr {
            let model = WCPhotoModel.initWithDict(dict: dict) as! WCPhotoModel
            dataSource.append(model)
        }
        
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WCPhotoCell.self), for: indexPath) as! WCPhotoCell
        cell.delegate = self
        cell.updateCellWithModel(model: dataSource[indexPath.item])
        return cell
    }

    //MARK: WCPhotoCellDelegate 
    func photoCell(cell: WCPhotoCell, btn: UIButton) {
        
        var selectedCount = 0
        if fromPublishVC {
            selectedCount = userDefaults.object(forKey: "SelectedImgCount") as! Int
        }
        
        if (selectCell.count + selectedCount) == 9 && !btn.isSelected {
            let alertView = WCAlertView.initWithTitle(title: "弹窗提示", message: "你最多只能选择9张照片", cancelButtonTitle: "我知道了")
            alertView.showWithCompletionBlock(completionBlock: nil)
            return
        }

        btn.isSelected = !btn.isSelected
        
        let indexPath = collectionView.indexPath(for: cell)
        let iconImage = dataSource[(indexPath?.item)!].icon
        
        if btn.isSelected {
            if !selectCell.contains(cell) {
                selectCell.append(cell)
                imageArray.append(iconImage!)
            }
        }else{
            if selectCell.contains(cell) {
                let index = selectCell.index(of: cell)
                selectCell.remove(at: index!)
                imageArray.remove(at: index!)
            }
        }
        
        if selectCell.count > 0 {
            previewBtn.isEnabled = true
            doneBtn.isEnabled = true
            numLabel.alpha = 1
            numLabel.text = "\(selectCell.count)"
        }else{
            previewBtn.isEnabled = false
            doneBtn.isEnabled = false
            numLabel.alpha = 0
            numLabel.text = "\(selectCell.count)"
        }
    }
    
    //MARK:Action
    func cancelItem() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func previewBtnAction(_ sender: UIButton) {
        
    }
    @IBAction func doneBtnAction(_ sender: UIButton) {
        
        self.cancelItem()
        
        if !fromPublishVC {
            let publishVC = WCPublishViewController()
            let publishNav = WCBaseNavController(rootViewController: publishVC)
            publishVC.imageArr = self.imageArray
            self.presentingViewController?.present(publishNav, animated: true, completion: nil)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Notification_SelectPhotos"), object: nil, userInfo: ["imageArr": self.imageArray])

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

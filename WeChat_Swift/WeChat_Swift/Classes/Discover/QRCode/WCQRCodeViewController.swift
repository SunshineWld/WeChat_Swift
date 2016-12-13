//
//  WCQRCodeViewController.swift
//  WeChat_Swift
//
//  Created by wanglidan on 16/11/17.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

import UIKit
import AVFoundation

let ratio = WindowZoomScale
let kBgImgX  = 45*ratio
let kBgImgY  = 110*ratio
let kBgImgWidth  = 230*ratio
let kScrollLineHeight = 20*ratio
let kTipHeight  = 40*ratio
let kTipY = (kBgImgY+kBgImgWidth+kTipHeight)

class WCQRCodeViewController: WCBaseViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var QRCode: String?
    var session: AVCaptureSession! //输入输出中间桥梁（会话）
    var link: CADisplayLink!        // 计时器
    var bgImg: UIImageView!         //有效扫描区域背景图
    var scrollLine: UIImageView!    //循环往返的线
    var tipLabel: UILabel!          //提示文字
    var down: Bool = true            //记录scrollLine的上下循环状态
 
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.white
        
        let rightItem = UIBarButtonItem(title: "相册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightItemAction))
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.setupViews()
        self.setupSession()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopRunning()
    }
    
    //开始
    func startRunning() {
        if self.session == nil {
            return
        }
        self.session.startRunning()
        self.link.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    //结束
    func stopRunning() {
        if self.session == nil {
            return
        }
        self.session.stopRunning()
    }
   
    func setupViews() {
        if bgImg == nil {
            bgImg = UIImageView(frame: CGRect(x: kBgImgX, y: kBgImgY, width: kBgImgWidth, height: kBgImgWidth))
            bgImg.image = UIImage(named: "scanBackground")
        }
        if scrollLine == nil {
            scrollLine = UIImageView(frame: CGRect(x: bgImg.left, y: bgImg.top, width: bgImg.width, height: kScrollLineHeight))
            scrollLine.image = UIImage(named: "scanLine")
        }
        if tipLabel == nil {
            tipLabel = UILabel(frame: CGRect(x: bgImg.left, y: bgImg.bottom, width: bgImg.width, height: kTipHeight))
            tipLabel.text = "将二维码/条码放入框内，即可自动扫描"
            tipLabel.textColor = UIColor.white
            tipLabel.textAlignment = NSTextAlignment.center
            tipLabel.font = UIFont.systemFont(ofSize: 14)
        }
        self.view.addSubview(bgImg)
        self.view.addSubview(scrollLine)
        self.view.addSubview(tipLabel)
        
        if link == nil {
            link = CADisplayLink(target: self, selector: #selector(lineAnimation))
        }
    }
    
    func setupSession() {
        if self.session == nil {
            //1.获取输入设备
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            if device == nil {
                WCAlertView.showMessage(message: "No camera on this device")
                return
            }
            //2.根据输入设备创建输入对象
            let input = (try! AVCaptureDeviceInput(device: device) as AVCaptureDeviceInput)
            
            //3.创建元数据的输出对象
            let output = AVCaptureMetadataOutput()
            
            //4.设置代理监听输出对象输出的数据,在主线程中刷新
            let metadataQueue = DispatchQueue.main
            output.setMetadataObjectsDelegate(self, queue: metadataQueue)
            
            //5.创建会话
            let session = AVCaptureSession()
            //实现高质量的输出和摄像，默认值为AVCaptureSessionPresetHigh，可以不写
            session.sessionPreset = AVCaptureSessionPresetHigh
            
            //6.添加输入和输出到会话中，判断session 是否已满
            if session.canAddInput(input) {
                session.addInput(input)
            }
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            
            //7.告诉输出对象，需要输出什么样的数据（二维码还是条形码），要先创建会话才能设置
            output.metadataObjectTypes = output.availableMetadataObjectTypes
            //            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode]
            
            //8.创建预览图层
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewLayer?.frame = self.view.bounds
            self.view.layer.insertSublayer(previewLayer!, at: 0)
            
            //9.设置有效扫描区域，默认整个图层（很特别，1.要除以屏幕宽高比例 2.其中x和y，width和height分别互换位置）
            let rect = CGRect(x: bgImg.top/SCREEN_HEIGHT, y: bgImg.left/SCREEN_WIDTH, width: bgImg.width/SCREEN_HEIGHT, height: bgImg.width/SCREEN_WIDTH)
            output.rectOfInterest = rect
            
            //10.设置中空区域，即有效扫描区域，（中间扫描区域透明度比周边要低的效果）
            let maskView = UIView(frame: self.view.bounds)
            maskView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.view.addSubview(maskView)

            let rectPath = UIBezierPath(rect: self.view.bounds)
            rectPath.append(UIBezierPath(roundedRect: CGRect(x: bgImg.left, y: bgImg.top, width: bgImg.width, height: bgImg.width), cornerRadius: 1).reversing())
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = rectPath.cgPath
            maskView.layer.mask = shapeLayer
            
            self.session = session
        }
    }
    
    //MARK: 线条运动的动画
    func lineAnimation() {
        if down == true {
            var y = self.scrollLine.frame.origin.y
            y += 2
            self.scrollLine.top = y
            if y >= (kBgImgY + kBgImgWidth - kScrollLineHeight) {
                down = false
            }
        }else {
            var y = self.scrollLine.frame.origin.y
            y -= 2
            self.scrollLine.top = y
            if y <= kBgImgY {
                down = true
            }
        }
    }
    
    //MARK: 打开相册
    func rightItemAction() {
        
    }
    
    //MARK: AVCaptureMetadataOutputObjectsDelegate
    //扫描到数据时会调用
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects.count > 0 {
            //停止扫描
            self.session.stopRunning()
            self.link.remove(from: RunLoop.main, forMode: RunLoopMode.commonModes)
            //取出扫描得到的数据
            let obj = metadataObjects.last as? AVMetadataMachineReadableCodeObject
            if (obj != nil) {
                //处理扫描到的二维码信息
                self.handleQRCodeInfo(message: (obj?.stringValue)!)
            }else{
                WCAlertView.showMessage(message: "没有扫描到有用的二维码或条形码")
            }
        }
    }
    
    func handleQRCodeInfo(message: String) {
        
        let url = URL.init(string: message)
        if UIApplication.shared.canOpenURL(url!) {
            let detailVC = WCQRCodeDetailViewController()
            detailVC.urlStr = message
            self.navigationController?.pushViewController(detailVC, animated: true)
        }else {
            let alertView = WCAlertView.initWithMessage(message: "不是有效网址，信息为\(message)")
            alertView.showWithCompletionBlock(completionBlock: { (index) in
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
}










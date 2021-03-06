//
//  ViewController.swift
//  11-二维码扫描
//
//  Created by 蒋鹏 on 16/10/18.
//  Copyright © 2016年 蒋鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "二维码识别/生成"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "扫描二维码", style: .plain, target: self, action: #selector(scanQRCode))
        
        /// 麦克风授权
        JKAppAuthorizationRequest.requestAudioAuthorization { (bbb) in
            
        }
        
        /// 相册授权
        JKAppAuthorizationRequest.requestPhotoLibraryAuthorization { (bbb) in

        }
        
        /// 通讯录授权
        JKAppAuthorizationRequest.requestAddressBookAuthorization { (bbb) in
            
        }
        
        /// 相机授权
        /// JKAppAuthorizationRequest.requestCameraAuthorization { (bbb) in}
        
        
        imageView = UIImageView.init()
        imageView?.contentMode = .scaleAspectFit
        imageView?.center = self.view.center
        imageView?.bounds = CGRect.init(x: 0, y: 0, width: 300, height: 300)
//        imageView?.backgroundColor = UIColor.clear
        self.view.addSubview(imageView!)
        
        self.imageView?.layer.shadowOffset = CGSize.init(width: 0, height: 1) // 设置阴影的偏移量
        self.imageView?.layer.shadowRadius = 1  // 设置阴影的半径
        self.imageView?.layer.shadowColor = UIColor.black.cgColor // 设置阴影的颜色为黑色
        self.imageView?.layer.shadowOpacity = 0.5 // 设置阴影的不透明度
        
        
        
        let image40 = UIImage.init(named: "AppIcon_40")
        
        var temp = image40.
        
        
        
    }
    
    
    
    
    func scanQRCode() -> Void {
        JKAppAuthorizationRequest.requestCameraAuthorization { (bbb) in
            
            /// 扫描二维码
            let scanVC = JKQRScanViewController.init()
            scanVC.jk_completionHandler({ (vc, str) in
                JKLOG(str)
                vc.navigationController?.dismiss(animated: true, completion: nil)
            })
            let nav = UINavigationController.init(rootViewController: scanVC)
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// 识别二维码图片
        JKQRCodeTool.jk_recognizeQRCodeImage(UIImage.init(named: "JKSwiftGitHub"), completionHandle: { (str, error) in
            if error != nil {
                JKLOG(error)
            } else {
                JKLOG(str)
                
                /// 生成二维码图片
                
                /// 黑白色
/*
 */
                JKQRCodeTool.jk_QRCodeImage(withString: str, size: CGSize.init(width: 500, height: 500), completionHandle: { (image, error1) in
                    if error1 != nil {
                        JKLOG(error1)
                    } else {
                        
                        // 带阴影效果
                        let tool = JKQRTool.init()
                        let newImage = tool.imageBlack(toTransparent: image, withRed: 0.2, andGreen: 0.5, andBlue: 0.8)
                        self.imageView?.image = newImage
                    }
                })
                
                /// 彩色
//                JKQRCodeTool.jk_QRCodeImage(withString: str, rgbColor: CIColor.init(red: 1, green: 0, blue: 0, alpha: 1), size: CGSize.init(width: 200, height: 200), completionHandle: { (image, error2) in
//                    if error2 != nil {
//                        JKLOG(error2)
//                    } else {
//                        self.imageView?.image = image
//                        
//                        
//                        /// 添加LOGO
////                        JKQRCodeTool.jk_addLogo(logo: UIImage.init(named: "logo"), forQRCodeImage: image, completionHandle: { (qrImage, error3) in
////                            if error3 != nil {
////                                JKLOG(error3)
////                            } else {
////                                self.imageView?.image = qrImage
////                                
////                                
////                                /// 识别二维码图片
////                                JKQRCodeTool.jk_recognizeQRCodeImage(qrImage, completionHandle: { (str, error4) in
////                                    if error4 != nil {
////                                        JKLOG(error4)
////                                    } else {
////                                        JKLOG(str)
////                                    }
////                                })
////                            }
////                        })
//                    }
//                })
                
            }
        })
        
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}


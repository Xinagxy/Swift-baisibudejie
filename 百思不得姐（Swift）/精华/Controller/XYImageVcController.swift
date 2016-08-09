//
//  XYImageVcController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/13.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import SVProgressHUD
class XYImageVcController: UIViewController {


    var imageView = UIImageView()

    @IBOutlet weak var barkScroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

    
        barkScroll.frame = CGRectMake(0, 0, screen_width, screen_height)

      
        //加载大图片
        let myWi = NSString(string: imageModel!.height!).floatValue
        imageView.kf_setImageWithURL(NSURL(string: imageModel!.large_image!)!, placeholderImage: nil)
        imageView.frame = CGRectMake(0, 0, screen_width, CGFloat(myWi))

        barkScroll.contentSize = CGSizeMake(0, CGFloat(myWi))
        barkScroll.addSubview(imageView)
    }

    
    var imageModel:XYTextModel?{
        
        didSet{
            
            
        }
    }
    
  
    
    @IBAction func share(sender: AnyObject) {
    }
    
    //下载
    @IBAction func downBut(sender: AnyObject) {
        
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>){
    
        if error == true {
            
            SVProgressHUD .showErrorWithStatus("保存失败")
            
        }else{
            SVProgressHUD .showSuccessWithStatus("保存成功")
            
        }
    }
    
    
    //返回
    @IBAction func backBut(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true , completion: nil)
    }

    //保存
    @IBAction func saveBut(sender: AnyObject) {
        
        
    }
    
   
}

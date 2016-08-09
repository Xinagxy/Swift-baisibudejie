//
//  XYPictureView.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/13.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import Kingfisher
import DACircularProgress
class XYPictureView: UIView {

    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var progrssImage: DALabeledCircularProgressView!
    @IBOutlet weak var gifImage: UIImageView!
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var buttonImage: UIButton!
    
    override func awakeFromNib() {
        
        self.autoresizingMask = .None
//        backImage
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "showPicture"))

    }
       
   //传递数据
    var pictureModel:XYTextModel!{
        didSet {
        self.progrssImage.setProgress(0.0, animated: false)
            //下载动态图，带进度条
        self.backImage.kf_setImageWithURL(NSURL(string: pictureModel!.middle_image!)!, placeholderImage: UIImage(named: "mine-icon-activity"), optionsInfo: nil, progressBlock: { (receivedSize, totalSize) -> () in
            
            self.buttonImage.hidden = true
            self.titleImage.hidden = false
            //进度比例 设置进度
            let progress = 1.0 * CGFloat(receivedSize) / CGFloat(totalSize)
            self.progrssImage.setProgress(progress, animated: true)
            
            //设置进度文字百分比
            self.progrssImage.hidden = false
            self.progrssImage.progressLabel.textColor = UIColor.redColor()
            self.progrssImage.progressLabel.text = NSString(format:"%.1f%%",progress*100) as String
            self.progrssImage.roundedCorners = 3;
        
            })//图片加载完成之后的回调
             { (image, error, cacheType, imageURL) -> () in
                
                //成功之后的回调
                self.progrssImage.hidden = true
                self.titleImage.hidden = true
                //判断是大图
                if self.pictureModel!.bigImage == 1{
                    // 开启图形上下文
                    UIGraphicsBeginImageContextWithOptions(self.backImage.size, true, 0.0);
                    // 将下载完的image对象绘制到图形上下文
                    let width = self.backImage.width;
                    let height = width * image!.size.height / image!.size.width
                    
                    //绘制一个需要大小的尺寸，把图像画到了当前的image context里
                    image?.drawInRect(CGRectMake(0, 0, width, height))
                    
                    // 获得图片
                    self.backImage.image = UIGraphicsGetImageFromCurrentImageContext()
                    // 结束图形上下文
                    UIGraphicsEndImageContext()
                    //显示Button
                    self.buttonImage.hidden = false
                }else {
                    self.backImage.contentMode = .ScaleToFill
                    self.buttonImage.hidden = true;
                }
            }
            
            //是gif
            if Int(pictureModel!.is_gif!) == 1{
                
                gifImage.hidden = false
            }else{
                gifImage.hidden = true
            }
        }
        
    }

    //点击查看大图或动态图
    @IBAction func butImage(sender: AnyObject) {
      
     showPicture()

    }
    
    
    func showPicture(){
        
        
        let imageVc = XYImageVcController()
        imageVc.imageModel = pictureModel
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(imageVc, animated: true, completion:nil )
        
        
        
    }
}

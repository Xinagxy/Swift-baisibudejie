//
//  XYVideoView.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/21.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import KRVideoPlayer
class XYVideoView: UIView {


    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var PlayCount: UILabel!
    @IBOutlet weak var playTime: UILabel!
    
   
    var videoController: KRVideoPlayerController?
    //传递模型数据
    var videoModel:XYTextModel!{
    
        didSet{
            backImage.kf_setImageWithURL(NSURL(string: videoModel!.middle_image!)!, placeholderImage: nil)
            //播放次数
            if Int(videoModel!.playcount!) >= 10000{
                let str = String(format: "%.1f万", Double(videoModel!.playcount!)!/10000.0)
                PlayCount.text = str+"播放"
            }else{
                PlayCount.text = videoModel!.playcount!+"播放"
                
            }
            
            let minute =  Int(videoModel!.videotime!)!/60
            let second  = Int(videoModel!.videotime!)!%60
            //播放时间
            playTime.text = NSString(format: "%02ld:%02ld", minute,second) as String
        }
    }
    func reset(){
        videoController?.dismiss()
        
    }
    
    //播放视频
    @IBAction func playVideo(sender: AnyObject) {
        
        if videoController == nil {
        videoController = KRVideoPlayerController.init(frame: backImage.bounds)

        weak var weakSelf = self
        videoController!.dimissCompleteBlock = {
            
            weakSelf!.videoController =  nil
        }
        videoController!.showInWindow()

        videoController!.contentURL = NSURL(string: videoModel!.videouri!)
        }
        
        self.addSubview(videoController!.view)
    }
    
}

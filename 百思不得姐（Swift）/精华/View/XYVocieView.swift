//
//  XYVocieView.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/21.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import AVFoundation
class XYVocieView: UIView {

    @IBOutlet weak var backImage: UIImageView!
  
    @IBOutlet weak var imageBackGroung: UIImageView!

    @IBOutlet weak var playCount: UILabel!
    
    
    @IBOutlet weak var playTime: UILabel!
    
    //开始播放按钮
    @IBOutlet weak var palyVoice: UIButton!
    
    //已经播放按钮
    @IBOutlet weak var endPalyVoice: UIButton!
    
    
    //已经播放的时间
    @IBOutlet weak var time: UILabel!
    //进度条
    @IBOutlet weak var progress: UISlider!
    //播放音乐显示背景
    @IBOutlet weak var backView: UIView!
    var  PeriodicTime : AnyObject?
    
    
    var  player =  AVPlayer()
    var songItem : AVPlayerItem?
    
    override func awakeFromNib() {
        
        progress.setValue(0.0, animated: true)
        progress.setThumbImage(UIImage(named: "kr-video-player-point"), forState: .Normal)
      
        
        //添加拖动手势
        let pan =  UIPanGestureRecognizer(target: self, action: "progressVaule:")
        progress.addGestureRecognizer(pan)
      
    }
    
    //传递数据
    var vocieModel:XYTextModel!{
        didSet {
        
            //背景
           backImage.kf_setImageWithURL(NSURL(string: vocieModel!.middle_image!)!, placeholderImage:nil)
           //播放次数
           playCount.text = vocieModel!.playcount!+"播放"
            
           let minute =  Int(vocieModel!.voicetime!)!/60
           let  second  = Int(vocieModel!.voicetime!)!%60
            //播放时间
            playTime.text = NSString(format: "%02ld:%02ld", minute,second) as String
            
        }
    }
    //播放
    @IBAction func palyVoice(sender: AnyObject) {
        palyVoice.hidden = true
        endPalyVoice.hidden = false
        time.hidden = false
        time.backgroundColor = UIColor.clearColor()
        playTime.backgroundColor = UIColor.clearColor()
        backView.hidden = false
        progress.hidden = false
        
        
        let url  = NSURL(string: vocieModel!.voiceuri!)!
        songItem = AVPlayerItem(URL: url)
        player = AVPlayer(playerItem: songItem!)
        player.play()
        // 监听AVPlayer播放完成通知
        XYNotification.addObserver(self, selector: "playbackFinish:", name: AVPlayerItemDidPlayToEndTimeNotification, object: songItem)
        
        
////      kvo  媒体加载状态
//        songItem!.addObserver(self, forKeyPath: "status", options: .New, context: nil)
////      kvo  数据缓冲状态
//        songItem!.addObserver(self, forKeyPath: "loadedTimeRanges", options: .New, context: nil)
        
        
       weak var weakSelf = self
        //监听播放进度 每到一定时间都会回调一次
       PeriodicTime = player.addPeriodicTimeObserverForInterval(CMTimeMake(1, 1), queue:dispatch_get_main_queue()) { (CMTime time) -> Void in
        
        //获取当前秒数
        let current = CMTimeGetSeconds(time);
        let total = CMTimeGetSeconds(weakSelf!.songItem!.duration);
        weakSelf!.progress.setValue(Float(current)/Float(total), animated: true)
        weakSelf!.time.text = NSString(format: "%02ld:%02ld", Int(current)/60,Int(current)%60) as String

        
        
        
        let arr =   (self.songItem!.loadedTimeRanges) as NSArray
            //本次缓冲的时间范围
        let cmTime =  (arr.firstObject?.CMTimeRangeValue)! as CMTimeRange
        //
        let totalBuffer = CMTimeGetSeconds(cmTime.start) + CMTimeGetSeconds(cmTime.duration) as NSTimeInterval //缓冲总长度
        //            progress.
        XYDEBUG("共缓冲\(NSString(format: "%.2f", totalBuffer))")
        

        }
    }
    
    
    
    //已经在播放
    @IBAction func endPalyVoice(sender: UIButton) {
        //取相反
        sender.selected = !sender.selected
        if sender.selected{
             XYDEBUG("暂停了")
             player.pause()
        }else{
             XYDEBUG("开始播放")
             player.play()
        }

    }
    
   
    //当cell不在当前的窗口就移除
    func reset(){
         XYDEBUG("reset \(songItem)")
       
        self.player.pause()
        progress.setValue(0.0, animated: true)
        //隐藏
        backView.hidden = true
        progress.hidden = true
        palyVoice.hidden = false
        endPalyVoice.hidden = true
        time.hidden = true
        time.backgroundColor = UIColor.darkGrayColor()
        playTime.backgroundColor = UIColor.darkGrayColor()
        
    }
    
    //播放完成移除
    func playbackFinish(notif : NSNotification){
        
        XYDEBUG("播放完成")
        
        player.removeTimeObserver(PeriodicTime!)
        songItem!.removeObserver(self, forKeyPath: "status")
        songItem!.removeObserver(self, forKeyPath: "loadedTimeRanges")
        songItem = nil
       
        progress.setValue(0.0, animated: true)
        //隐藏
        backView.hidden = true
        progress.hidden = true
        palyVoice.hidden = false
        endPalyVoice.hidden = true
        time.hidden = true
        time.backgroundColor = UIColor.darkGrayColor()
        playTime.backgroundColor = UIColor.darkGrayColor()
    }
    
    
    //拖动的时候，计算比例
     func progressVaule(sender: UIGestureRecognizer) {
        
        // 1.获取点击的位置
        let locat =  sender.locationInView(sender.view)
        // 2.获取点击的在slider长度中占据的比例
        let ratio = locat.x / self.progress.bounds.size.width;
        // 3.改变歌曲播放的时间
        let cd = CMTimeGetSeconds(songItem!.duration)
        //音频跳转指定位置
        songItem?.seekToTime(CMTimeMake(Int64(CGFloat(cd) * ratio), 1), completionHandler: { (Bool bool) -> Void in
           self.player.play()
        })
    }
    
    //    KVO方法中获取其status的改变
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        let songAv = object as? AVPlayerItem
        if (keyPath == "status"){
            switch player.status{
            case .ReadyToPlay :
                XYDEBUG("播放")
                player.play()
                break
            case .Failed :
                XYDEBUG("Failed")
                break
            case .Unknown :
                XYDEBUG("未知状态")
                break
            }
        }else if(keyPath == "loadedTimeRanges"){
            let arr =   (songAv?.loadedTimeRanges)! as NSArray
            //            //本次缓冲的时间范围
            let cmTime =  (arr.firstObject?.CMTimeRangeValue)! as CMTimeRange
            //
            let totalBuffer = CMTimeGetSeconds(cmTime.start) + CMTimeGetSeconds(cmTime.duration) as NSTimeInterval //缓冲总长度
            
//            progress.
            
            XYDEBUG("共缓冲\(NSString(format: "%.2f", totalBuffer))")
        }
    }
}

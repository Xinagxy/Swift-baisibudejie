//
//  XYTextModel.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/11.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import MJExtension
class XYTextModel: NSObject {
    
    var ID:String?
    // 用户 -- 发帖者
    var name:String?
    /** 用户的头像 */
    var profile_image:String?
    /** 帖子的文字内容 */
    var text:String?
    /** 帖子审核通过的时间 */
//    var created_at:String?
    /** 顶数量 */
    var  ding:String?
    /** 踩数量 */
    var cai:String?
    /** 转发\分享数量 */
    var repost:String?
    /** 评论数量 */
    var comment:String?
    
    /** 是否为gif图片 */
    var is_gif:String?
    /** 视频或图片类型帖子的宽度 */
    var width:String?
    /** 视频或图片类型帖子的高度 */
    var height:String?
    
    
    /** 音频的时长 */
    var voicetime:String?
    /** 播放次数 */
    var playcount:String?
    /** 音频的播放地址 */
    var voiceuri:String?
    
    
    /** 视频的播放地址 */
    var videouri:String?
    /** 视频的时长 */
    var videotime:String?
    
    
    
    /** 小图片*/
    var small_image:String?
    /** 中图片*/
    var middle_image:String?
    /** 大图片 */
    var large_image:String?
    
    
    /****** 是否为大图 ******/
    var bigImage:Int = 0
    
    
    /**
     1 // 全部
     10 // 图片
     29 // 段子
     31 // 声音
     41 // 视频
     */
    var type:NSNumber?
    
    /*  追加的属性 */
    var contentViewFrame:CGRect?//图片或视频或声音内容尺寸

    var _created_at:String?
    var created_at:String?{
        
        get{
        
         let dataformat =  NSDateFormatter()
            XYDEBUG(dataformat)
         dataformat.locale =  NSLocale(localeIdentifier: "zh_CN")
         dataformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
          
         //将字符串转为NSdata 
        let currdata =  dataformat.dateFromString(_created_at!)
        //当前时间
        let nowData = NSDate.init()
         
            
         //创建日历对象，比较差值
        let cureentCal =  NSCalendar.currentCalendar()
     
        let component =  cureentCal.components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Day,NSCalendarUnit.Hour,NSCalendarUnit.Minute,NSCalendarUnit.Second,], fromDate: currdata!, toDate: nowData, options: .WrapComponents)
            
            //是否今年
            if((currdata?.isThisYear()) == true){
                
                if((currdata?.isYesterday()) == true){//是否为昨天
                    
                     dataformat.dateFormat = "昨天 HH:mm"
                   
                     return dataformat.stringFromDate(currdata!)
                }else if((currdata?.isToday()) == true){//是否为今天
                    if(component.hour >= 1){
                         XYDEBUG(component.hour)
                      return  NSString.init(format: "%d小时前", component.hour) as String
                    }else if(component.minute >= 1){
                        
                      return  NSString.init(format: "%d分钟前", component.minute) as String
                    }else{
                        
                        return "刚刚"
                    }
                    
                }else{ //今年的某月某日
                    
                    dataformat.dateFormat = "MM-dd HH:mm";
                    return dataformat.stringFromDate(currdata!)
                    
                }
            }else{//不是今年
                
                dataformat.dateFormat = "yyyy-MM-dd HH:mm";
                return dataformat.stringFromDate(currdata!)
                
            }
            
            
        }set(currentime){
            
            _created_at = currentime
            
        }
    }
    
    var heightCell:CGFloat?{
        
        get{
            //顶部的高
            let topheight:CGFloat = 55
            //底部的高
            let bonheight:CGFloat = 35
            let textStr =  self.text! as NSString
            //中间文字的高
            let textSize =  textStr.boundingRectWithSize(CGSizeMake(screen_width - 30, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(17)], context: nil).size
            //最大x
            let max = topheight + textSize.height+5
            //不是段子
            if self.type != 29{
               let width_X = screen_width - 30
                
                
                let myWi = NSString(string: height!).floatValue
                let myhe = NSString(string: height!).floatValue
                
                let contentViewx:CGFloat = 10
                let contentViewy:CGFloat = max
                let scale_w:CGFloat = CGFloat(myWi)/width_X
                var contentViewH = CGFloat(myhe)/scale_w
//                XYDEBUG("width:\(width_X)   height:\(contentViewH)")
                //如果是视频 并且宽度是250
                if (self.type == 41 && contentViewH > 250) {
                    contentViewH = 250
                    bigImage = 1
                }
                
                if (myhe > 1500) {
                    contentViewH = 300
                    bigImage = 1
                }
                
                self.contentViewFrame = CGRectMake(contentViewx, contentViewy, width_X, contentViewH)
                
                return topheight+bonheight+textSize.height+25+CGFloat(contentViewH)
            }else{

                return topheight+bonheight+textSize.height+25
            }
            
            
           
        }
    }
    
}

extension XYTextModel{
    
    
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
    
        
        return [
            "small_image" : "image0",
            "large_image" : "image1",
           "middle_image" : "image2",
            "ID" : "id",
            "top_cmt" : "top_cmt[0]"
        ]
    }
    
}

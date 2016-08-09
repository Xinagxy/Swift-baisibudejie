//
//  File.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/9.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

enum topicType:Int{
    
   case TopicTypeAll = 1 // 全部
   case TopicTypePicture = 10 // 图片
   case TopicTypeTalk = 29 // 段子
   case TopicTypeVoice = 31 // 声音
   case TopicTypeVideo = 41 // 视频
};

func XYDEBUG<T>(message: T, file: NSString = __FILE__, method: String = __FUNCTION__, line: Int = __LINE__)
{
//    该打印函数会打印文件名,方法名
    #if DEBUG
        print("\(method)[\(line)]: \(message)")
    #endif
}

/** 导航栏最大的Y值 */
public let  XYNavBarMaxY:CGFloat = 64;
/** TitlesView的高度 */
public let XYTitlesViewH:CGFloat = 35

public let XYColor:UIColor = UIColor(red: 243/255.0, green: 243/255.0, blue: 243/255.0, alpha: 1.0)

public let XYScrollColor:UIColor = UIColor(red: 215/155.0, green: 215/155.0, blue: 215/155.0, alpha: 215/155.0)

public let XYTabColor:UIColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1.0)

public let MYColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)

public let XYrequestUrl = "http://api.budejie.com/api/api_open.php"

public var XYUserDefaults = NSUserDefaults.standardUserDefaults()
public var XYNotification = NSNotificationCenter.defaultCenter()
// 屏幕大小尺寸
let screen_width  = UIScreen.mainScreen().bounds.size.width
let screen_height = UIScreen.mainScreen().bounds.size.width


public let MYFriendUserIdentifier = "user"
public let MYFriendIdentifier = "XYMyFriendTable"

public let MYMeCell = "MYMeCell"
public let MYsubCell = "subCell"

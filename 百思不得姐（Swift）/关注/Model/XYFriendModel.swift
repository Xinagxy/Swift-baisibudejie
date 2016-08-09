//
//  XYFriendModel.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/29.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYFriendModel: NSObject {
    
  
    /** id */
    var id: String?
    /** 名字 */
    var name: String?
    
    
    
    //额外
    /** 当前的页码 */
    var page: Int?
    /** 这个类别对应的用户数据 */
//    var users:NSMutableArray?

     /**  用户数据  */
    var users = NSMutableArray()

}

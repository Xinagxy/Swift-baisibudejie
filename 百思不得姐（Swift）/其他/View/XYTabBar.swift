//
//  XYTabBar.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/8.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYTabBar: UITabBar {

    var publishButton = UIButton()
    //重写init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundImage = UIImage(named: "tabbar-light")
        //添加中间的发布按钮
        publishButton.setBackgroundImage(UIImage(named: "tabBar_publish_icon"), forState:.Normal)
        publishButton.setBackgroundImage(UIImage(named: "tabBar_publish_click_icon"), forState:.Highlighted)
        
        publishButton.sizeToFit()
        
        publishButton.addTarget(self, action: "publishClick", forControlEvents:.TouchUpInside)
        self.addSubview(publishButton)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //按钮点击跳转
    func publishClick(){
    
      UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(PublishController(), animated: false, completion: nil)
        
    }
    
    /**
     * 布局子控件
     */
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        var  index = 0
        // tabBar的尺寸
        let width:CGFloat = self.width
        let height:CGFloat = self.height
        // 设置发布按钮的位置
        publishButton.center = CGPointMake(width * 0.5, height * 0.5)
        // 按钮的尺寸
        let tabBarButtonW:CGFloat = width / 5;
        let tabBarButtonH:CGFloat = height;
        let tabBarButtonY:CGFloat = 0;
        
        for  tabBarButton:UIView in self.subviews{
        //Swift中 == 等同于 OC中 isEqualToString  比较两个字符串
            if (!(NSStringFromClass(tabBarButton.classForCoder) == "UITabBarButton")) {continue}
            
            // 计算按钮的X值
            var tabBarButtonX = CGFloat(index) * tabBarButtonW
            if (index >= 2) { // 给后面2个button增加一个宽度的X值
                tabBarButtonX = tabBarButtonW + tabBarButtonX;
            }
            // 设置按钮的frame
            tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
            index++;
        }
    }
}
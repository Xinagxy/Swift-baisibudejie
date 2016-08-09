//
//  XYTabController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/8.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChild()
        // 统一给所有的UITabBarItem设置文字属性
        let item = UITabBarItem.appearance();

        item.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.grayColor(),NSFontAttributeName: UIFont.systemFontOfSize(12)], forState: UIControlState.Normal)//
        item.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.darkGrayColor(),NSFontAttributeName: UIFont.systemFontOfSize(12)], forState: UIControlState.Selected)//
        
        /**
        * 处理TabBar 替换成自定义的
        */
        self.setValue(XYTabBar(), forKeyPath: "tabBar")
        
    }
    func setupChild(){
        
         CreationChild("精华", image: "tabBar_essence_icon", selectImage: "tabBar_essence_click_icon", childVC: XYEssenceController())
        
         CreationChild("最新", image: "tabBar_new_icon", selectImage: "tabBar_new_click_icon", childVC: XYNewViewController())
        
         CreationChild("关注", image: "tabBar_friendTrends_icon", selectImage: "tabBar_friendTrends_click_icon", childVC: XYFriendTrendsController())
        
         CreationChild("我", image: "tabBar_me_icon", selectImage: "tabBar_me_click_icon", childVC: XYMeController())

    }
    
    func CreationChild(title: String , image: String ,selectImage: String , childVC: UIViewController){
        
   //   imageWithRenderingMode不根据系统的样式
        childVC.tabBarItem = UITabBarItem(title: title, image: UIImage(named: image)?.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: selectImage)?.imageWithRenderingMode(.AlwaysOriginal))
        
        let Nav = XYNavController.init(rootViewController: childVC)
        addChildViewController(Nav)
        
        
    }

}

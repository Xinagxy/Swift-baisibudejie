//
//  XYFriendTrendsController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/28.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYFriendTrendsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
        self.navigationItem.title = "我的关注";
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(icon: "friendsRecommentIcon", highIcon: "friendsRecommentIcon-click", target: self, action: "MYFriend")
    }

    
    func MYFriend(){
        
        let MYFriendVc = XYMyFriendController()
        
        self.navigationController?.pushViewController(MYFriendVc, animated: true)
        
    }
    
    
    @IBAction func logUser(sender: AnyObject) {
        
        let logVc = XYLognController()
        presentViewController(logVc, animated: true, completion: nil)
        
    }

}

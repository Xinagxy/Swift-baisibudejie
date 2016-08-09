//
//  XYNavController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/8.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYNavController: UINavigationController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if (self.viewControllers.count>0){
            
            viewController.hidesBottomBarWhenPushed = true
            let button = UIButton.init(type: .Custom)
            button.setImage(UIImage.init(named: "navigationButtonReturn"), forState: .Normal)
            button.setImage(UIImage.init(named: "navigationButtonReturnClick"), forState: .Highlighted)
            button.setTitle("返回", forState: .Normal)
            button.setTitleColor(UIColor(red: 81/255, green: 81/255, blue: 81/255, alpha: 1), forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
            button.addTarget(self, action: "close", forControlEvents: .TouchUpInside)
            button.frame.size = CGSize(width: 100, height: 30)
            //  button 里的内容左对齐
            button.contentHorizontalAlignment = .Left
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            
           viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
           
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func close(){
        
        
        self.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

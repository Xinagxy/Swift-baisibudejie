//
//  XYMyFriendController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/29.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class PublishController: UIViewController {
    
    
    @IBOutlet weak var titleConst: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.userInteractionEnabled = false
        self.containerView.transform = CGAffineTransformMakeTranslation(0, -500)

        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animateWithDuration(0.5,delay: 0,usingSpringWithDamping: 0.7,
            initialSpringVelocity: 10,
            options: .CurveEaseInOut,
            animations: { () -> Void in
            self.containerView.transform = CGAffineTransformIdentity
            
            }) { (bool:Bool) -> Void in
                self.view.userInteractionEnabled = true
                self.titleConst.constant = 100
        }
    }
    
    // MARK: 取消
    @IBAction func cancel() {
        
        self.view.userInteractionEnabled = false
        self.containerView.transform = CGAffineTransformIdentity
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.containerView.transform = CGAffineTransformMakeTranslation(0, 500)
            self.titleConst.constant = -140
            }) { (bool:Bool) -> Void in
                self.dismissViewControllerAnimated(false, completion: nil)
        }
        
        
        
    }
    
    
    
}

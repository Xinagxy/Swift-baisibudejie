//
//  XYLognController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/28.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYLognController: UIViewController {
    @IBOutlet weak var loginBut: UIButton!
    @IBOutlet weak var leftSpcing: NSLayoutConstraint!
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var loginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  

    @IBAction func closeBut(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
  
    //收回键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func reginBun(sender: UIButton) {
        
        //         修改约束
        if (self.leftSpcing.constant == 0){
            XYDEBUG(-(self.view.width))
            leftSpcing.constant =  -(self.view.width)
            sender.selected = true

            
        }else{
            
            leftSpcing.constant = 0
            sender.selected = false
        }
        
        UIView.animateWithDuration(0.2) { () -> Void in
            
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func LoginButtion(sender: UIButton) {



        
    }
}

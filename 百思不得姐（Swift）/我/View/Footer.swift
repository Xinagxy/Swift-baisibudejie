//
//  Footer.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/8/5.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import Alamofire
class Footer: UIView {

  
    var FootArr = NSMutableArray()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
       
        self.backgroundColor = UIColor.clearColor()
        
        //请求数据
        let params = NSMutableDictionary()
        
        params["a"] = "square";
        params["c"] = "topic";
        
        
        weak var weakSelf = self
        Alamofire.request(.GET, XYrequestUrl, parameters:NSDictionary(dictionary: params) as? [String: AnyObject]).responseJSON() { response in
            
            switch response.result{
            case .Success:

               let JSON = response.result.value
               //得到字典数组数据
                let footModel = JSON!.valueForKey("square_list") as? NSArray
               // 字典数组 -> 模型数组
                weakSelf?.FootArr =  XYFootModel.mj_objectArrayWithKeyValuesArray(footModel)
               
               XYDEBUG(weakSelf?.FootArr.count)
               if(weakSelf?.FootArr.count > 0){
                
                weakSelf?.CreatButton((weakSelf?.FootArr)!)
                
                }
            case .Failure(let error):
                
                print(error)

            }
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func CreatButton(creatButton : NSMutableArray){
        let maxCols:CGFloat = 4
        //等宽
        let buttonW = screen_width / maxCols
        let buttonH = buttonW

         for i in 0 ..< FootArr.count{
            let  but = XYfootBut.footBut() as! XYfootBut
           //设置frame
            let col = CGFloat(i) % maxCols
            let row = i / Int(maxCols)
            but.frame = CGRectMake(col * buttonW, CGFloat(row) * buttonH, buttonW, buttonH)
            
            XYDEBUG(but.frame)
            if (i == 12){
                let footBut =  NSBundle.mainBundle().loadNibNamed("XYfootBut", owner: nil, options: nil) as NSArray
                let but = footBut.lastObject as! XYfootBut
                but.frame = CGRectMake(col * buttonW, CGFloat(row) * buttonH, buttonW, buttonH)
                self.addSubview(but)
                return
            }
            
            but.footModel = creatButton[i] as? XYFootModel
            self.addSubview(but)
        }

    }
    

}

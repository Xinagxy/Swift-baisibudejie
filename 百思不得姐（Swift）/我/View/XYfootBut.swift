//
//  XYfootBut.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/8/5.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import Kingfisher
class XYfootBut: UIButton {

    @IBOutlet weak var imageBut: UIImageView!
  
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        
    self.setBackgroundImage(UIImage.init(named: "mainCellBackground"), forState: .Normal)
        
    }
    
    class func footBut() -> AnyObject{
    
        let footBut =  NSBundle.mainBundle().loadNibNamed("XYfootBut", owner: nil, options: nil) as NSArray
        return footBut.lastObject!
    
    }
    
    var footModel : XYFootModel?{
        
        didSet{
            
           imageBut.kf_setImageWithURL(NSURL(string: footModel!.icon!)!, placeholderImage: UIImage(named: "mine-icon-activity"))
           title.text = footModel?.name
            
        }
    }

}

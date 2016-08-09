//
//  XYSubscribeCell.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/8/5.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import Kingfisher
class XYSubscribeCell: UITableViewCell {

    @IBOutlet weak var subName: UILabel!
    @IBOutlet weak var subNum: UILabel!
  
    @IBOutlet weak var subImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
        
    }

    var  SubModel : XYSubModel?{
        
        didSet{
            
            
         subName.text = SubModel!.theme_name
           
         if Int(SubModel!.sub_number!) >= 10000{
                let str = String(format: "%.1f万订阅", Double(SubModel!.sub_number!)!/10000.0)
                subNum.text = str
          }else if Int(SubModel!.sub_number!) > 0{
                
                subNum.text = "\(SubModel!.sub_number!)+订阅"
          }
            
          subImage.kf_setImageWithURL(NSURL(string: SubModel!.image_list!)!, placeholderImage: UIImage(named: "defaultUserIcon"))
            
            
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
        
    }
    
}

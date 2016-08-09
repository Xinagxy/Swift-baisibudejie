//
//  XYTableUserCell.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/29.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import Kingfisher
class XYTableUserCell: UITableViewCell {

    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var nameUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    var UserModel:XYUserModel?{
    
        didSet{
            
          
           name.text = UserModel!.screen_name
            if (Int(UserModel!.fans_count!)! >= 10000) {
                
                let myWi = NSString(string: UserModel!.fans_count!).floatValue
                nameUser.text = NSString(format:"%.1f万人关注", CGFloat(myWi) / 10000) as String
            } else {
                let myWi = NSString(string: UserModel!.fans_count!).floatValue
                nameUser.text = NSString(format:"%ld人关注", Int(myWi)) as String
            }
            
            
            userImage.kf_setImageWithURL(NSURL(string: UserModel!.header!)!, placeholderImage: UIImage(named: "defaultUserIcon"))
            
        }
    
    }
}

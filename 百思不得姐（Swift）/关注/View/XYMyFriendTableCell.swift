//
//  XYMyFriendTableCell.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/29.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYMyFriendTableCell: UITableViewCell {

    @IBOutlet weak var selectIndicator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    /**
     * 这个方法可以用来监听cell的选中和取消选中
     */
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        XYDEBUG(selected)
        //选择为红色文字
        self.textLabel?.textColor = selected ? UIColor.redColor(): UIColor.darkGrayColor()
        selectIndicator.hidden = !selected
        
    }
    
    
    var FriendModel:XYFriendModel?{
        
         didSet{
            
           self.textLabel?.text = FriendModel!.name
            
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 为了显示白色边线 并且textLable居中
        textLabel?.frame.origin.y = 1
        textLabel?.frame.size.height = textLabel!.frame.height - 2
        
    }
    
}

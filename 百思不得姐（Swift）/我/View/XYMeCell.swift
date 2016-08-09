//
//  XYMeCell.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/8/4.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYMeCell: UITableViewCell {

    
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        
            self.textLabel!.textColor = UIColor.darkGrayColor()
            self.textLabel!.font = UIFont.systemFontOfSize(14)


        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //重写布局 修改image
    override func layoutSubviews() {
        
        
        super.layoutSubviews()
        
        if (self.imageView!.image == nil){
            return
        }
        self.imageView!.width = 30
        self.imageView!.height = 30
        self.imageView!.centerY = self.contentView.height * 0.5
        self.textLabel!.x = CGRectGetMaxX(self.imageView!.frame) + 10
        
    }

  
}

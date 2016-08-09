//
//  XYMeController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/8/2.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYMeController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    private lazy var bthLeft:UIButton = {
    
       let bthLeft = UIButton()
        
        bthLeft.frame = CGRectMake(0, 0, screen_width/2, 44);
        bthLeft.setTitle("#自拍#", forState:.Normal)
        bthLeft.titleLabel!.font = UIFont.systemFontOfSize(15)
        bthLeft.setTitleColor(UIColor.darkGrayColor(), forState:.Normal)
        
        return bthLeft
    
    }()
    private lazy var btnRight:UIButton = {
        
        let btnRight = UIButton()
        
        btnRight.frame = CGRectMake(screen_width/2, 0, screen_width/2, 44);
        btnRight.setTitle("#我是段子手#", forState:.Normal)
        btnRight.titleLabel!.font = UIFont.systemFontOfSize(15)
        btnRight.setTitleColor(UIColor.darkGrayColor(), forState:.Normal)
        
        return btnRight
        
    }()
    
    private lazy var verticalLine:UIView = {
        
        let verticalLine = UIView()
        verticalLine.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        verticalLine.frame = CGRectMake(screen_width/2, 2, 0.5, 40);
        return verticalLine
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = MYColor
        // 设置导航栏标题
        navigationItem.title = "我的"
        //cell的间距
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.registerClass(XYMeCell.self, forCellReuseIdentifier: MYMeCell)
        
        
        tableView.sectionFooterHeight = 15
        //尾部 是单独的view  写一个继承View的类
        self.tableView.tableFooterView = Footer.init(frame: CGRectZero)
        
        
        setupBar()
    }
    
    func setupBar(){
        
        let ringht1 =   UIBarButtonItem.init(icon: "mine-setting-icon", highIcon: "mine-setting-icon-click", target: self, action: "right1")
        ringht1.customView?.width = 20
        let ringht2 =   UIBarButtonItem.init(icon: "mine-moon-icon", highIcon: "mine-moon-icon-click", target: self, action: "right2")
        ringht2.customView?.width = 20
        
        //增加一个有一定宽度的UIBarButtonItem  调整间距
        let bar =  UIBarButtonItem.init(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        bar.width = 20
        navigationItem.rightBarButtonItems = [ringht1,bar,ringht2]
        
    
        
        let left1 =   UIBarButtonItem.init(icon: "nav_coin_icon", highIcon: "nav_coin_icon_click", target: self, action: "left1")
        navigationItem.leftBarButtonItem = left1
    }
    
    
    func right1(){
        
        
    }
    func right2(){
        
        
    }
    func left1(){
        
        
    }
 
    
    // MARK: - tableView Datasource 
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(MYMeCell) as? XYMeCell
        cell?.selectionStyle = .None
     
        
        if (indexPath.section == 0) {
            
            cell!.imageView?.image = UIImage(named: "defaultUserIcon")
            cell!.textLabel!.text = "登录/注册"
            cell!.accessoryType = .DisclosureIndicator
            
        } else if (indexPath.section == 1) {
            
            cell!.textLabel!.text = "离线下载"
            cell!.accessoryType = .DisclosureIndicator
            
        }else{
            
            cell?.addSubview(bthLeft)
            cell?.addSubview(btnRight)
            cell?.addSubview(verticalLine)
            
        }
        
        return cell!
        
        
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
        
        return 25
        }
        return 15
    }

}

//
//  XYEssenceController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/8.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYEssenceController: UIViewController {
    var scrollView = UIScrollView()
    //标签栏
    var titlesView = UIView()
    var titleButton = UIButton()
    
    //选中的button
    var selectedTitleButton = UIButton()
    
    //红色标签栏
    var titleBottomView = UIView()
    
    
    //存放按钮的数组
    lazy var titleButtons:NSMutableArray = {
        var tmpArray:NSMutableArray! = NSMutableArray()
        
        return tmpArray
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.titleView = UIImageView(image:UIImage(named: "MainTitle"))
        // 导航栏左边的内容 MainTagSubIcon  MainTagSubIconClick
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(icon: "MainTagSubIcon", highIcon: "MainTagSubIconClick", target: self, action: "ChilcBarButtion")
        
        
        setupChildVc()
        setupScrollView()
        setupTitlesView()

    }

    //子控制器
    func setupChildVc(){
        
        ChildVc(XYAllTableViewController(), title: "全部")
        ChildVc(XYVoideTabController(), title: "视频")
        ChildVc(XYVoiceTabController(), title: "声音")
        ChildVc(XYImageTabController(), title: "图片")
        ChildVc(XYtextTabController(), title: "段子")
    }
    
    func ChildVc(tabVc: UITableViewController, title: String){
        tabVc.title = title;
        addChildViewController(tabVc)
    }
    
    //创建scrollView 将子控制的Tabview添加到scrollView上
    func setupScrollView(){
        
        // 不要自动调整scrollView的contentInset
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.frame = self.view.bounds;
        scrollView.backgroundColor = XYScrollColor
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSizeMake(CGFloat(childViewControllers.count) * self.view.width, 0);
        self.view.addSubview(scrollView)
        
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func setupTitlesView(){
        
        // 标签栏整体
        titlesView.backgroundColor = XYColor
        titlesView.frame = CGRectMake(0, XYNavBarMaxY, self.view.width, XYTitlesViewH)
        self.view.addSubview(titlesView)
        // 标签栏内部的标签按钮
        let count = childViewControllers.count
        let titleButtonH:CGFloat = titlesView.height
        let titleButtonW:CGFloat = titlesView.width / CGFloat(count);
        for (var i = 0; i < count; i++) {
            
            let titleButton = UIButton()
             // frame
            titleButton.y = 0;
            titleButton.height = titleButtonH;
            titleButton.width = titleButtonW;
            titleButton.x = CGFloat(i) * titleButton.width;
            
            titleButton.setTitleColor(UIColor.darkGrayColor(), forState:.Normal)
            titleButton.setTitleColor(UIColor.redColor(), forState:.Selected)
            titleButton.addTarget(self, action: "titleClick:", forControlEvents: .TouchUpInside)
            //文字
            titleButton.titleLabel!.font = UIFont.systemFontOfSize(14)
            titleButton.setTitle(childViewControllers[i].title!, forState:.Normal)

            titlesView.addSubview(titleButton)
            
            //添加到数组中
            titleButtons.addObject(titleButton)
            self.titleButton = titleButton
            
            
        }
        // 标签栏底部的指示器控件
        titleBottomView.backgroundColor = titleButtons.lastObject?.titleColorForState(.Selected)
        titleBottomView.height = 2;
        titleBottomView.y = titlesView.height - titleBottomView.height;
        titlesView.addSubview(titleBottomView)
    
        // 默认点击最前面的按钮
        let firstTitleButton = titleButtons.firstObject as? UIButton;
        firstTitleButton!.titleLabel!.sizeToFit()
        titleBottomView.width = firstTitleButton!.titleLabel!.width;
        titleBottomView.centerX = firstTitleButton!.centerX;
        titleClick(firstTitleButton!)
    }
    
//MARK:左上角按钮
    func ChilcBarButtion(){
      
        self.navigationController?.pushViewController(XYSubscribeView(), animated: true)
        
    }
    
    //按钮点击
    func titleClick(titlebut: UIButton){
        // 控制按钮状态
        selectedTitleButton.selected = false;
        titlebut.selected = true;
        self.selectedTitleButton = titlebut;
          // 底部控件的位置和尺寸
        UIView.animateWithDuration(0.25) { () -> Void in
            self.titleBottomView.width = titlebut.titleLabel!.width;
            self.titleBottomView.centerX = titlebut.centerX;
        }

        // 让scrollView滚动到对应的位置
        var offset = self.scrollView.contentOffset;
        offset.x = self.view.width * CGFloat(self.titleButtons.indexOfObject(titlebut))
        self.scrollView.setContentOffset(offset, animated: true)
        
    }
}


//MARK:扩展类 实现协议
extension XYEssenceController:UIScrollViewDelegate{
    /**
      当滚动动画完毕的时候调用
     */
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        // 取出对应的子控制器
        let index = scrollView.contentOffset.x / scrollView.width;
        let willShowChildVc = childViewControllers[Int(index)] as? UITableViewController
        
        // 添加子控制器的view到scrollView身上
        willShowChildVc!.view.frame = scrollView.bounds;
        //设置内边距
        let top = XYNavBarMaxY + XYTitlesViewH
        let bottom:CGFloat = 44.0
        willShowChildVc!.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
        // 设置滚动条的内边距
        willShowChildVc!.tableView.scrollIndicatorInsets = willShowChildVc!.tableView.contentInset;
        scrollView.addSubview(willShowChildVc!.view)
    }
    /**
    * 当减速完毕的时候调用
    */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
        //scrollView移动的位置获取相对于点击的按钮
        let index = scrollView.contentOffset.x / scrollView.width;
        titleClick(titleButtons[Int(index)] as! UIButton)
    }

}


//
//  XYMyFriendController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/29.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import MJExtension
import SVProgressHUD
class XYMyFriendController: UIViewController{

    /**  左侧目录tableView  */
     @IBOutlet weak var leftView: UITableView!
     /**  右侧目录tableView  */
     @IBOutlet weak var rightView: UITableView!
    
    /**  当前选中左边的标签数据  */
     var leftModel:XYFriendModel?
    
    /**  左侧标签列标  */
    var dataArr =  NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "推荐关注"
    
        setupTable()
        loadLeftData()
    }
    func setupTable(){
        self.view.backgroundColor = UIColor.init(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
        
        automaticallyAdjustsScrollViewInsets = false
        
        let inset = UIEdgeInsetsMake(64, 0, 0, 0)
        leftView.contentInset = inset
        leftView.scrollIndicatorInsets = inset
        leftView.separatorStyle = .None
        
        
        let rightinset = UIEdgeInsetsMake(64, 0, 0, 0)
        rightView.contentInset = rightinset
        rightView.scrollIndicatorInsets = inset
        rightView.separatorStyle = .None
        rightView.rowHeight = 70
        //注册cell
        leftView.registerNib(UINib(nibName: "XYMyFriendTableCell", bundle: nil), forCellReuseIdentifier: MYFriendIdentifier)

        rightView.registerNib(UINib(nibName: "XYTableUserCell", bundle: nil), forCellReuseIdentifier: MYFriendUserIdentifier)
        
        
        
        rightView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: "loadNewData")
        // 自动改变透明度
        rightView.mj_header.automaticallyChangeAlpha = true
       
        // 上拉刷新 loadMoredata
        rightView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: "loadMoredata")
        
    }
    
    
    
   func loadLeftData(){
    SVProgressHUD.show()
    // 请求参数
    let params = NSMutableDictionary()
    params["a"] = "category";
    params["c"] = "subscribe";
    
    
    weak var weakSelf = self
    Alamofire.request(.GET, XYrequestUrl, parameters:NSDictionary(dictionary: params) as? [String: AnyObject]).responseJSON() { response in
        switch response.result{
          case .Success:
            SVProgressHUD.dismiss()
            
            let JSON = response.result.value
            //得到字典数组数据
            let TextModel = JSON!.valueForKey("list") as? NSArray
            weakSelf?.dataArr = XYFriendModel.mj_objectArrayWithKeyValuesArray(TextModel)
            // 刷新表格
            weakSelf?.leftView.reloadData()
            //先走一遍选中方法，获取到当前选中的标签，这样就不会出现nil值崩溃现象
            weakSelf?.tableView((weakSelf?.leftView)!, didSelectRowAtIndexPath:NSIndexPath.init(forRow: 0, inSection: 0))
            //默认第一行
            weakSelf?.leftView.selectRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0), animated: false, scrollPosition: .Top)
            
        case .Failure(let error):
             SVProgressHUD.dismiss()
            XYDEBUG(error)
        }
       }
    
    }
    //MARK: 加载新的数据
    func loadNewData(){
        // 请求参数
        let params = NSMutableDictionary()
        params["a"] = "list";
        params["c"] = "subscribe";
        params["category_id"] = self.leftModel?.id
           //页码
        self.leftModel!.page = 1
        weak var weakSelf = self
         Alamofire.request(.GET, XYrequestUrl, parameters:NSDictionary(dictionary: params) as? [String: AnyObject]).responseJSON() { response in
            switch response.result{
            case .Success:
             
            let refreshModel = self.leftModel
                
            let JSON = response.result.value
            //得到字典数组数据
            let TextModel = JSON!.valueForKey("list") as? NSArray
            refreshModel!.users =  XYUserModel.mj_objectArrayWithKeyValuesArray(TextModel)
            
            // 刷新表格
            weakSelf?.rightView.reloadData()
            // 结束刷新
            weakSelf?.rightView.mj_header.endRefreshing()
//            XYDEBUG(TextModel)
            
            case .Failure(let error):
                weakSelf?.rightView.mj_header.endRefreshing()
                XYDEBUG(error)
            }
        }
    }
    //MARK: 加载更多数据
    func loadMoredata(){
        
        // 请求参数
        let params = NSMutableDictionary()
        params["a"] = "list";
        params["c"] = "subscribe";

        
        params["category_id"] = self.leftModel!.id
        // 页码
        let page = leftModel!.page! + 1
        params["page"] = page
        
        weak var weakSelf = self
        
          Alamofire.request(.GET, XYrequestUrl, parameters:NSDictionary(dictionary: params) as? [String: AnyObject]).responseJSON() { response in
            switch response.result{
            case .Success:
                
                //页码
                weakSelf?.leftModel!.page = page
                
                let JSON = response.result.value
                //得到字典数组数据
                let TextModel = JSON!.valueForKey("list") as? NSArray
                
                let userData =  XYUserModel.mj_objectArrayWithKeyValuesArray(TextModel)
                
                weakSelf?.leftModel?.users.addObjectsFromArray(userData! as [AnyObject])
                // 刷新表格
                weakSelf?.rightView.reloadData()
                // 结束刷新
                weakSelf?.rightView.mj_header.endRefreshing()
//                XYDEBUG(TextModel)
                
            case .Failure(let error):
                weakSelf?.rightView.mj_header.endRefreshing()
                XYDEBUG(error)
            }
        }

    }
}
//MARK: UITableViewDataSource 如何下面三个实现类没实现就一直报错
extension XYMyFriendController :UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tableView == leftView{
            
            return dataArr.count
        }else{
//            ?? -- 空合运算符 为空时  取0 否则取本值
            return leftModel?.users.count ?? 0
        }
    }
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if (tableView == leftView){
            
            let FriendModel = self.dataArr[indexPath.row] as? XYFriendModel

            let myfriend =  tableView.dequeueReusableCellWithIdentifier(MYFriendIdentifier) as! XYMyFriendTableCell
            myfriend.FriendModel = FriendModel
            return myfriend
        }else{
 
             let myfrienduser =  tableView.dequeueReusableCellWithIdentifier(MYFriendUserIdentifier) as! XYTableUserCell
            myfrienduser.UserModel = leftModel?.users[indexPath.row] as? XYUserModel
            return myfrienduser
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        if (tableView == self.leftView){
            
            //将当前选中的值赋值给 leftModel
           leftModel = dataArr[indexPath.row] as? XYFriendModel
            self.rightView.reloadData()
            
            //同时刷新右边表哥
            self.rightView.mj_header.beginRefreshing()
            // 判断是否有过用户数据
            // 防止重新加载数据
            if (self.leftModel?.users.count == 0){
                rightView.mj_header.beginRefreshing()
            }
        }
    }
}

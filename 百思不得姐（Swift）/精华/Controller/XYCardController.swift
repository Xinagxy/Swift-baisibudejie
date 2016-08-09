//
//  XYCardController.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/11.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.

import UIKit
import Alamofire
import MJExtension
import MJRefresh
import Kingfisher

class XYCardController: UITableViewController {
   
    var dataArr = NSMutableArray()
    
    /** 用来加载下一页数据 */
    var nextData:String?
    private let Cell = "CarCell"
    /** 加载页码  */
    var page: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = XYTabColor;
        // 去掉分割线
        tableView.separatorStyle = .None
        
        tableView.registerNib(UINib(nibName: "XYCardCell", bundle: nil), forCellReuseIdentifier: Cell)
        
        steupRefresh()
    }
    //MARK: 子类重写
     func Mycard()->Int{
        
        return 0
     }
    
    func steupRefresh(){
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: "steupData")
        self.tableView.mj_header.beginRefreshing()
        // 自动改变透明度
        self.tableView.mj_header.automaticallyChangeAlpha = true
        
        // 上拉刷新 loadMoredata
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: "loadMoredata")
    }
    
    //MARK: 下拉刷新数据
    func steupData(){
        page = 0
        // 请求参数
        let params = NSMutableDictionary()
        params["a"] = self.parentViewController!.isKindOfClass(XYNewViewController) ? "newlist" : "list"
        params["c"] = "data"
        params["type"] = self.Mycard()
        
        weak var weakSelf = self
        Alamofire.request(.GET, XYrequestUrl, parameters:NSDictionary(dictionary: params) as? [String: AnyObject]).responseJSON() { response in
            
            switch response.result{
            case .Success:
                let JSON = response.result.value
                //得到字典数组数据
                let TextModel = JSON!.valueForKey("list") as? NSArray
                // 字典数组 -> 模型数组
                weakSelf?.dataArr =  XYTextModel.mj_objectArrayWithKeyValuesArray(TextModel)
                // 存储maxtime
                let infoJson  = JSON!["info"]! as? NSDictionary
                weakSelf?.nextData = infoJson!["maxtime"] as? String
                
                // 刷新表格
                weakSelf?.tableView.reloadData()
                // 结束刷新
                weakSelf?.tableView.mj_header.endRefreshing()
            case .Failure(let error):
                
                print(error)
                weakSelf?.tableView.mj_header.endRefreshing()
                
            }
        }
    }
    //MARK: 上拉加载更多
    func loadMoredata(){
        
    
        page = page+1
        // 请求参数
        let params = NSMutableDictionary()
        //如果是新帖，就加载newlist
        params["a"] = self.parentViewController!.isKindOfClass(XYNewViewController) ? "newlist" : "list"
        params["c"] = "data"
        params["type"] = self.Mycard()
        params["maxtime"] = self.nextData
        params["page"] = (page)
        XYDEBUG("maxtime\(self.nextData!)  page\(page) ")
        weak var weakSelf = self
        Alamofire.request(.GET, XYrequestUrl, parameters:NSDictionary(dictionary: params) as? [String:AnyObject]).responseJSON() { response in
            switch response.result{
            case .Success:
                let JSON = response.result.value
                //得到字典数据
                let TextModel = JSON!.valueForKey("list") as? NSArray
                // 字典数组 -> 模型数组
                let dataArr =  XYTextModel.mj_objectArrayWithKeyValuesArray(TextModel)
                
                weakSelf?.dataArr.addObjectsFromArray(dataArr as [AnyObject])
                
                
                // 存储maxtime
                let infoJson  = JSON!["info"]! as? NSDictionary
                weakSelf?.nextData = infoJson!["maxtime"] as? String
            
                // 刷新表格
                weakSelf?.tableView.reloadData()
                // 结束刷新
                weakSelf?.tableView.mj_footer.endRefreshing()
            case .Failure(let error):
                weakSelf?.tableView.mj_footer.endRefreshing()
                XYDEBUG(error)
            }
        }
    }
    // MARK: 代理
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.dataArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let textModel =  self.dataArr[indexPath.row] as? XYTextModel
        let cell =  tableView.dequeueReusableCellWithIdentifier(Cell, forIndexPath: indexPath) as? XYCardCell

        //传递模型数据
        cell!.selectModel = textModel!
        
        return cell! 
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
       let textModel =  self.dataArr[indexPath.row] as? XYTextModel
        return (textModel?.heightCell)!
    }

}

//
//  XYSubscribeView.swift
//  百思不得姐（Swift）
//  Created by 尧的mac on 16/8/5.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.

import UIKit
import Alamofire
import SDAutoLayout
class XYSubscribeView: UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate{

    var subArr = NSMutableArray()
    
    @IBOutlet weak var covnBut: UIButton!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var search: UISearchBar!
  
    var _searchRestlt:XYSubSearchResult?
 
    var searchRestlt:XYSubSearchResult?{
        
        get{
            let searchRestlt = XYSubSearchResult()
            addChildViewController(searchRestlt)
            _searchRestlt = searchRestlt
            self.view.addSubview(searchRestlt.view)
            //约束 到其父view上左下右的间距
//           let layoutMo =  _searchRestlt!.view.sd_layout() as SDAutoLayoutModel
//           layoutMo.leftSpaceToView(view,10)
//            .topSpaceToView(view, -64)
            return searchRestlt

        }set(Restlt ){
            
            _searchRestlt = Restlt
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
           setupData()
//        automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .None
        navigationItem.title = "标签订阅"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(icon: "tag_add_icon", highIcon: "tag_add_icon", target: self, action: "ChilcBarButtion")
        
         view.backgroundColor = UIColor.init(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
         tableView.tableHeaderView = UIButton.init(type: .ContactAdd)
        
         tableView.registerNib(UINib(nibName: "XYSubscribeCell", bundle: nil), forCellReuseIdentifier: MYsubCell)
        
      
    }
    func setupData(){
        //请求数据
        let params = NSMutableDictionary()
        params["a"] = "tags_list";
        params["c"] = "subscribe";
        weak var weakSelf = self
        Alamofire.request(.GET, XYrequestUrl, parameters:NSDictionary(dictionary: params) as? [String: AnyObject]).responseJSON() { response in
            switch response.result{
            case .Success:
                
                let JSON = response.result.value
                //得到字典数组数据 rec_tags
                //得到字典数组数据
                let footModel = JSON!.valueForKey("rec_tags") as? NSArray
                
                XYDEBUG(footModel)
                // 字典数组 -> 模型数组
                weakSelf!.subArr =  XYSubModel.mj_objectArrayWithKeyValuesArray(footModel)
                weakSelf!.tableView.reloadData()
            case .Failure(let error):
                
                print(error)
            }
        }
    }

//MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
         XYDEBUG(subArr.count)
        return subArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let SubModel = subArr[indexPath.row] as? XYSubModel
        let cell = tableView.dequeueReusableCellWithIdentifier(MYsubCell, forIndexPath: indexPath) as? XYSubscribeCell
        cell?.SubModel = SubModel
        XYDEBUG(cell)

        return cell!
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    
    
    }
    //MARK:UITextFieldDelegate
    //开始编辑
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animateWithDuration(0.6) { () -> Void in
            
            self.covnBut.alpha = 0.6
        }
    }
    
    
    
    /**
     *  搜索框里面的文字变化的时候调用
     */
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.isEmpty) {
            self.searchRestlt!.view.hidden = true
        } else {
        
            
            self.searchRestlt!.view.hidden = false
            self.searchRestlt!.searchText = searchText;//将输入的值进行匹配查询
        }
    }
    
    @IBAction func covBut(sender: AnyObject) {
        self.view.endEditing(true)
        UIView.animateWithDuration(0.6) { () -> Void in
            
            self.navigationController?.setNavigationBarHidden(false, animated: false)

            self.covnBut.alpha = 0.0
        }
        
    }
  
}

//
//  AppDelegate.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/8.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
  
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        //设置根控制器
        self.window?.rootViewController = XYTabController()
        self.window?.makeKeyAndVisible()
        showFirstView()
        
        
        //加载广告图片 官方数据请求为nil
//      addAdvertImage()
        let adver =  AdvertiseView.init(frame: self.window!.bounds)
        adver.filePath = "http://imgsrc.baidu.com/forum/w%3D580/sign=5d67856da6cc7cd9fa2d34d109002104/bca6169b033b5bb53822be7e33d3d539b400bcc8.jpg"
        adver.show()
        
        
        return true
    }

    func showFirstView(){
       //获得系统当前版本号
      let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as? String
        //获取沙盒版本
      let lastVersion =  XYUserDefaults.stringForKey("currentVersion")
       
        if (!(currentVersion == lastVersion)){
          let arr =   NSBundle.mainBundle().loadNibNamed("XYFirstView", owner: nil, options: nil) as NSArray
          
          let frist = arr.lastObject as! XYFirstView
          frist.frame = (self.window?.bounds)!
          self.window?.addSubview(frist)
            
           //当前版本写入沙盒
            XYUserDefaults.setObject(currentVersion, forKey: "currentVersion")
            XYUserDefaults.synchronize()
        }
        
        
    }
    
    
    func addAdvertImage(){
    
        //请求数据
        let params = NSMutableDictionary()
        let inte :Int = 1
        params["demo"] = "1"
        params["entrytype"] = inte
        
        weak var weakSelf = self
        Alamofire.request(.GET, "http://sprite.spriteapp.com/ad/get.php", parameters:NSDictionary(dictionary: params) as? [String: AnyObject]).responseJSON() { response in
            
            switch response.result{
            case .Success:
                let JSON = response.result.value
                //得到字典数组数据
                let footModel = JSON!.valueForKey("return") as? NSDictionary
                
                let foordict =  footModel!["data"] as? NSDictionary
                let adResList =  foordict!["adResList"] as? NSDictionary
                let munga =  adResList!["6294"] as? NSDictionary
                let picIMage =  munga!["pic"] as? String
                
                XYDEBUG(picIMage)
                if (foordict != nil){
               
               
                }
            case .Failure(let error):
                
                print(error)
                
            }
            
        }

    
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        
        let cache = KingfisherManager.sharedManager.cache
        
        //清理内存缓存
        cache.clearMemoryCache()
        
        // 清理硬盘缓存，这是一个异步的操作
        cache.clearDiskCache()
        
        // 清理过期或大小超过磁盘限制缓存。这是一个异步的操作
        cache.cleanExpiredDiskCache()
    }

}


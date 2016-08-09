//
//  XYCardCell.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/7/11.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit
import Kingfisher
class XYCardCell: UITableViewCell {

    
    @IBOutlet weak var imageUser: UIImageView!
    
    
    @IBOutlet weak var nameUser: UILabel!
    
    
    @IBOutlet weak var timeUser: UILabel!
    
    @IBOutlet weak var textUser: UILabel!
    
    @IBOutlet weak var dingBut: UIButton!
    @IBOutlet weak var caiBut: UIButton!
    
    @IBOutlet weak var share: UIButton!
    
    @IBOutlet weak var componBut: UIButton!
    
    
    //懒加载 图片对象
   private lazy var pictureImage:XYPictureView = {
    let pauc = NSBundle.mainBundle().loadNibNamed("XYPictureView", owner: nil
        , options: nil) as NSArray
    let prict = pauc.lastObject as! XYPictureView
    self.contentView.addSubview(prict)

      return prict
    }()

    
   private lazy var VocieView:XYVocieView = {
    
    let voceiView =  NSBundle.mainBundle().loadNibNamed("XYVocieView", owner: nil, options: nil) as NSArray
    let vocie = voceiView.lastObject as! XYVocieView
    self.contentView.addSubview(vocie)
    return vocie
    
    }()
    
    private lazy var VideoView:XYVideoView = {
    
    
        let videoView =  NSBundle.mainBundle().loadNibNamed("XYVideoView", owner: nil, options: nil) as NSArray
        
        let video = videoView.lastObject as! XYVideoView
        
        self.contentView.addSubview(video)
        
        return video
    
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
        
    }
    //重写frame
    override var frame:CGRect{
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10/2
            newFrame.size.width -= 10
            newFrame.origin.y += 10
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
    //传递model数据  set方法
    var selectModel:XYTextModel?{
        didSet {
           

        //顶部
        imageUser.kf_setImageWithURL(NSURL(string: selectModel!.profile_image!)!, placeholderImage: UIImage(named: "defaultUserIcon"))
        nameUser.text = selectModel!.name
        timeUser.text = selectModel!.created_at
        textUser.text = selectModel!.text
            
        //中间 段子是不需要判断的，所有的都不是就是段子了
            /**
            1 // 全部
            10 // 图片
            29 // 段子
            31 // 声音
            41 // 视频
            */
            if selectModel!.type == 10{
                XYDEBUG("图片")
                let selModel = selectModel
                pictureImage.pictureModel = selModel
                pictureImage.frame = selectModel!.contentViewFrame!
                
                pictureImage.hidden = false
                VocieView.hidden = true
                VideoView.hidden =  true
            }else if (selectModel!.type == 31) {
            
               XYDEBUG("声音")
                let selModel = selectModel
                VocieView.vocieModel = selModel
                VocieView.frame = selectModel!.contentViewFrame!
                
                VocieView.hidden = false
                pictureImage.hidden = true
                VideoView.hidden = true

            }else if (selectModel!.type == 41)  {
                
                XYDEBUG("视频")
                let selModel = selectModel
                VideoView.videoModel = selModel
                VideoView.frame = selectModel!.contentViewFrame!
                
                VideoView.hidden = false
                VocieView.hidden = true
                pictureImage.hidden = true
                
            }else{
                XYDEBUG("段子："+"\(selectModel!.type)")
                VocieView.hidden = true
                pictureImage.hidden = true
                VideoView.hidden = true

            }
         
        //底部
        setToolBut(dingBut, numberBut: selectModel!.ding!, titleBut: "顶")
        setToolBut(caiBut, numberBut: selectModel!.cai!, titleBut: "踩")
        setToolBut(share, numberBut: selectModel!.repost!, titleBut: "分享")
        setToolBut(componBut, numberBut: selectModel!.comment!, titleBut: "评论")
        }
    }

    func setToolBut(toolBut: UIButton,numberBut: String , titleBut:String){
        
        if Int(numberBut) >= 10000{
            let str = String(format: "%.1f万", Double(numberBut)!/10000.0)
            toolBut.setTitle(str, forState: .Normal)
        }else if Int(numberBut) > 0{
            
            toolBut.setTitle("\(Int(numberBut)!)", forState: .Normal)
        }else{
            toolBut.setTitle(titleBut, forState: .Normal)
        }
    }
    
//   当被重用的cell将要显示时，会调用这个方法
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        VocieView.reset()
        VideoView.reset()
        
    }
}

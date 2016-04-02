
//
//  QPNetWorking.swift
//  DoubanFM.Mac.Swift
//
//  Created by ZQP on 14-10-29.
//  Copyright (c) 2014年 ZQP. All rights reserved.
//

import Cocoa
import Foundation
import AppKit
import Alamofire

class QPNetWorking: NSObject {

    class func shareInstance()->QPNetWorking{
        struct YRSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:QPNetWorking? = nil
        }
        
        dispatch_once(&YRSingleton.predicate,{
            YRSingleton.instance=QPNetWorking()
            }
        )
        return YRSingleton.instance!
    }
    
    func getChannelList(completionHandle:(([ChannelModel])->Void) ,failureHandle:((error:NSError)->Void))->Void
    {
         Alamofire.request(.GET, "http://www.douban.com/j/app/radio/channels", parameters: nil)
            .responseJSON(completionHandler: { (response) in
                if ((response.data) == nil){
                    failureHandle(error: response.result.error ?? NSError.init(domain: "com.alamofire.douban", code: 400, userInfo: nil))
                    return
                }
                
                var array=[ChannelModel]()
                
                let responseDic = response.result.value as? Dictionary<String,[Dictionary<String,AnyObject>]>;
                if (nil == responseDic)
                {
                    failureHandle(error: response.result.error ?? NSError.init(domain: "com.alamofire.douban", code: 400, userInfo: nil))
                    return
                }
                
                let responseArray=responseDic!["channels"]!
                
                for dic in responseArray
                {
                    let name_en=dic["name_en"] as! String
                    let seq_id=dic["seq_id"] as! Int
                    let abbr_en=dic["abbr_en"] as! String
                    let name=dic["name"] as! String
                    var channel_id:String?=nil
                    if dic["channel_id"] is Int{
                        channel_id=String(format: "%d", dic["channel_id"] as! Int)
                    }else if dic["channel_id"] is String{
                        channel_id=dic["channel_id"] as? String
                    }
                    
                    let model=ChannelModel(name_en: name_en, seq_id: seq_id, abbr_en: abbr_en, name: name, channel_id:channel_id!)
                    array.append(model)

                }
            completionHandle(array)
        })
    }
    
    func getSongsListWithChannelId(channelID:String,completionHandle:(([MusicModel])->Void),failureHandle:((error:NSError)->Void)){
        let string="http://douban.fm/j/mine/playlist?channel="+channelID
        
       request(.GET, string, parameters: nil, encoding: .JSON)
        
        .responseJSON(completionHandler: { (response) in
            if (response.data==nil){
                failureHandle(error: response.result.error ?? NSError.init(domain: "com.alamofire.douban", code: 400, userInfo: nil))
            }
            
            let responseDic = response.result.value as! Dictionary<String,AnyObject>
            
            let responseObject=responseDic["song"] as! [Dictionary<String,AnyObject>]
            
            var array_musicModel=[MusicModel]()
            for item in responseObject{
                
                let picture_url=item["picture"] as! String
                let url=item["url"] as! String
                let title=item["title"] as! String
                let albumTitle=item["albumtitle"] as! String
                
                let model_music=MusicModel(picture: picture_url, url: url, title: title, albumtitle: albumTitle)
                array_musicModel.append(model_music)
            }
            completionHandle(array_musicModel)
        })
    }
  
    
    
}

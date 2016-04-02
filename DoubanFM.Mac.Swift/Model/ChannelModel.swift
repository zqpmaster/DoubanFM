//
//  ChannelModel.swift
//  DoubanFM.Mac
//
//  Created by ZQP on 14-10-30.
//  Copyright (c) 2014年 ZQP. All rights reserved.
//

import Cocoa

class ChannelModel {
    let name_en:String
    let seq_id:Int
    let abbr_en:String
    let name:String
    let channel_id:String?
    
    init(name_en:String,seq_id:Int,abbr_en:String,name:String,channel_id:String){
        self.name_en=name_en;
        self.seq_id=seq_id;
        self.abbr_en=abbr_en;
        self.name=name;
        self.channel_id=channel_id
        
    }
}

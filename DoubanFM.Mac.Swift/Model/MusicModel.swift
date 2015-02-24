//
//  MusicModel.swift
//  DoubanFM.Mac.Swift
//
//  Created by ZQP on 14-10-30.
//  Copyright (c) 2014年 ZQP. All rights reserved.
//

import Cocoa

class MusicModel {
    let picture:String
    let url:String
    let title:String
    let albumtitle:String
    
    init(picture:String,url:String,title:String,albumtitle:String){

        self.picture=picture
        self.url=url
        self.title=title
        self.albumtitle=albumtitle
    }
}

//
//  QPPlayer.swift
//  DoubanFM.Mac
//
//  Created by ZQP on 14-11-9.
//  Copyright (c) 2014年 ZQP. All rights reserved.
//

import Cocoa
import Foundation


private let shareInstance=QPPlayer()
class QPPlayer: NSObject {
    class var sharedManager : QPPlayer {
        return shareInstance
    }
    
//    let musicPlayer=SoundManger()
}

//
//  AppDelegate.swift
//  DoubanFM.Mac.Swift
//
//  Created by ZQP on 14-8-31.
//  Copyright (c) 2014年 ZQP. All rights reserved.
//

import Cocoa
import AppKit
import Foundation
import Alamofire;

class AppDelegate: NSObject, NSApplicationDelegate {
                            
//    @IBOutlet weak var window: NSWindow!
    var mainWindow:MainWindowController?;
    
    

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        Alamofire.request(.GET, "http://www.douban.com/j/app/radio/channels", parameters: nil, headers: ["User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36"]).response { (request, response, data, error) in
            print(error);
            print(error);
            print(error);
            print(error);
            print(error);

        };
        
        
        Alamofire.request(.GET, "http://www.baidu.com", parameters: nil).responseData { (response) in
            print(response.data);
        }
        
        mainWindow=MainWindowController(windowNibName: "MainWindowController");
        mainWindow?.showWindow(self);

//        mainWindow?.window?.backgroundColor=NSColor(calibratedRed:0.908 ,green:0.940, blue:0.995, alpha:1.000)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
//    func applicationDockMenu(_ sender: NSApplication!) -> NSMenu!{
//        let dockMenu=NSBundle.mainBundle.loadNibNamed(nibName:"DockMenu" ,owner:self, topLevelObjects:nil)
//        
//        return dockMenu;
//    }
//    @IBAction func playMenuItem(sender: AnyObject) {
//        mainWindow?.playFunc(sender);
//    }
//
//    @IBAction func stopMenuItem(sender: AnyObject) {
//        mainWindow?.playAction(sender)
//    }
//    
//    @IBAction func nextSongItem(sender: AnyObject) {
//        mainWindow?.nextSong(sender)
//    }
//    
//    @IBAction func lastSongItem(sender: AnyObject) {
//        mainWindow?.lastSong(sender)
//    }
    
}


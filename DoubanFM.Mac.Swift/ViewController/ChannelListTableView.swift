//
//  ChannelListTableView.swift
//  DoubanFM.Mac
//
//  Created by ZQP on 14-10-29.
//  Copyright (c) 2014年 ZQP. All rights reserved.
//

import Cocoa
import AppKit
import Foundation

class ChannelListTableView: NSViewController,NSTableViewDelegate,NSTableViewDataSource{

    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var tableView: NSTableView!
    var _array_channelModel:[ChannelModel]=[ChannelModel]()
    weak var _windowController:MainWindowController?
//        willSet{
//            
//        }
    
    override func viewDidLoad() {
            super.viewDidLoad()
//        self.view.wantsLayer=true;
//        self.view.layer?.backgroundColor=NSColor.blackColor().CGColor;
        // Do view setup here.
    }
    
     func reloadTableData()->Void{
        QPNetWorking.shareInstance().getChannelList({ (array_Model) -> Void in

            self._array_channelModel=array_Model
            self.tableView!.reloadData()

        }, failureHandle: { (error) -> Void in
            let alertView=NSAlert(error: error);
            alertView.runModal()
        })
    }
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int{
    
        return self._array_channelModel.count;
    }
//    func tableView(aTableView: NSTableView!, objectValueForTableColumn aTableColumn: NSTableColumn!, row rowIndex: Int) -> AnyObject!{
//        let model=self._array_channelModel[rowIndex] as ChannelModel
//        return model.name
//    }
    
    func tableView(aTableView: NSTableView, shouldSelectRow rowIndex: Int) -> Bool{
        return true;
    }
    func selectionShouldChangeInTableView(aTableView: NSTableView) -> Bool{
        return true;
    }
    func tableViewSelectionDidChange(changeNotification aNotification: NSNotification!){
        
        

        
    }
    func tableViewSelectionIsChanging(aNotification: NSNotification){
        let tableView=aNotification.object as! NSTableView
        let index=tableView.selectedRow
        
        let model=self._array_channelModel[index] as ChannelModel
        
        self._windowController?._channelModel=model
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView?{
    
        let tableCellView=tableView.makeViewWithIdentifier("ChannelCell", owner: self) as! NSTableCellView
        let model=self._array_channelModel[row] as ChannelModel
        tableCellView.textField?.stringValue=model.name
        tableCellView.wantsLayer=true
        var color:NSColor?
        if row%2==0{
            color=NSColor.whiteColor()
        }else{
            color=NSColor(calibratedRed:0.908 ,green:0.940, blue:0.995, alpha:1.000)
        }
        tableCellView.layer?.backgroundColor=color!.CGColor
        
        return tableCellView
    }

}

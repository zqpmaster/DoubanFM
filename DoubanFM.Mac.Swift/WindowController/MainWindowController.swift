//
//  MainWindowController.swift
//  DoubanFM.Mac
//
//  Created by ZQP on 14-10-29.
//  Copyright (c) 2014年 ZQP. All rights reserved.
//

import Cocoa
import AppKit
import Foundation
import QuartzCore

class MainWindowController: NSWindowController ,NSTableViewDelegate,NSTableViewDataSource{
    
    @IBOutlet weak var playButton: NSButton!
    @IBOutlet weak var _selectChannelButton: NSButton!
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var stopButton: NSButton!
    
    @IBOutlet weak var musicListTableView: NSTableView!
    
    @IBOutlet weak var imageView: DKAsyncImageView!

    var isChannelMode:Bool=true
    var channelList:ChannelListTableView!;
    
    var _muarray_musicModel=[MusicModel]()
    
    var _player:NSSound?
    
    var _selectIndex:Int=Int(-1)
    

//    var _channelId:String?{
//        willSet{
//            
//        }
//        didSet{
//            
//        }
//    }
    var _channelModel:ChannelModel?{
        set{
            self._selectChannelButton.title=newValue!.name
            self.transitionButtonFunc(NSButton())

            let disTime:dispatch_time_t=dispatch_time(DISPATCH_TIME_NOW, Int64(0.6*Double(NSEC_PER_SEC)))
            dispatch_after(disTime, dispatch_get_main_queue()) { () -> Void in
                self.reloadMusicList(newValue!.channel_id!)
            }
        }
        get{
            return nil
        }
    }
    override func windowDidLoad() {
        super.windowDidLoad()
        channelList=ChannelListTableView(nibName:"ChannelListTableView",bundle:NSBundle.mainBundle());
        channelList.view.frame=NSRectFromCGRect(CGRectMake(0, 0, 200, 300));
//        channelList.view.hidden=true
        
//        self.window!.contentView=channelList.view;
        self.window?.contentView!.addSubview(channelList.view);

//        channelList.view.alpha=1.0
//        self.musicListTableView.alphaValue=0.0
        
        self.musicListTableView.selectionHighlightStyle=NSTableViewSelectionHighlightStyle.SourceList
//        self.musicListTableView.wantsLayer=true;
//        self.musicListTableView.layer?.backgroundColor=NSColor.whiteColor().CGColor

        channelList.tableView.selectionHighlightStyle=NSTableViewSelectionHighlightStyle.SourceList
//        channelList.tableView.wantsLayer=true;
//        channelList.tableView.layer?.backgroundColor=NSColor.whiteColor().CGColor

        channelList.reloadTableData()
        channelList._windowController=self;
        
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    @IBAction func playAction(sender: AnyObject) {
        self._player?.resume()
        self.swithchPlayButtonState(true)

    }
    @IBAction func stopAction(sender: AnyObject) {
        self._player?.pause()
        self.swithchPlayButtonState(false)
    }
    @IBAction func nextSong(sender: AnyObject) {
        
        if _selectIndex+1<self._muarray_musicModel.count{
            _selectIndex += 1;
            let model=self._muarray_musicModel[_selectIndex] as MusicModel
            
            self.p_playMusicWithNSUrl(model,index:_selectIndex)
        }

    }
    
    @IBAction func lastSong(sender: AnyObject) {
        if _selectIndex-1 > -1{
            _selectIndex -= 1;
            let model=self._muarray_musicModel[_selectIndex] as MusicModel
            
            self.p_playMusicWithNSUrl(model,index:_selectIndex)
        }

    }
    func reloadMusicList(channelId:String){
        
        QPNetWorking.shareInstance().getSongsListWithChannelId(channelId, completionHandle: { (musicModelArray) -> Void in

            self._muarray_musicModel=musicModelArray
            self.musicListTableView.reloadData()
            self.p_playMusicWithNSUrl(musicModelArray[0],index:0)
            self._selectIndex=0

        }) { (error) -> Void in
            let alertView=NSAlert(error: error);
            alertView.runModal()

        }
//        QPNetWorking.shareInstance().getSongsListWithChannelId(_channelId!, completionHandle: { (musicModelArray) -> Void in
//        })
    }
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int{
        
        return self._muarray_musicModel.count;
    }
    func tableView(aTableView: NSTableView, objectValueForTableColumn aTableColumn: NSTableColumn?, row rowIndex: Int) -> AnyObject?{
        let model=self._muarray_musicModel[rowIndex] as MusicModel

//            if (self._player != nil)  {
//                self._player?.play();
//            }
        return model.title
    }
    
    func tableView(aTableView: NSTableView, shouldSelectRow rowIndex: Int) -> Bool{
        return true;
    }
    func selectionShouldChangeInTableView(aTableView: NSTableView) -> Bool{
        return true;
    }
    func tableViewSelectionDidChange(changeNotification aNotification: NSNotification!){    
        
        
        
    }
    @IBAction func transitionButtonFunc(sender: AnyObject) {
        isChannelMode=(!isChannelMode)
        if(isChannelMode){
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                context.duration=0.5
                self.channelList.view.animator().setFrameOrigin(NSPoint(x:  0, y: 0));
                self.channelList.view.animator().setFrameSize(NSSize(width: 200, height: 300));
                
                }, completionHandler: { () -> Void in
                    
            })

        }else{
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                context.duration=0.5
                self.channelList.view.animator().setFrameOrigin(NSPoint(x: 0, y: 300));
                self.channelList.view.animator().setFrameSize(NSSize(width: 200, height: 0));
                
                }, completionHandler: { () -> Void in
                    
            })

        }
        
       

//        )
//
//        let transitionMusicList:CATransition=CATransition();
//        transitionMusicList.duration=0.5
//        transitionMusicList.timingFunction=CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        transitionMusicList.type=kCATransitionReveal
//        transitionMusicList.subtype = kCATransitionFromBottom
//        
//        self.musicListTableView.hidden=isChannelMode;
//        self.musicListTableView.layer?.addAnimation(transitionMusicList, forKey: "animation")
//        
//
//        let transitionChannelList:CATransition=CATransition();
//        transitionChannelList.duration=0.5
//        transitionChannelList.timingFunction=CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        transitionChannelList.type=kCATransitionReveal
//        transitionChannelList.subtype = kCATransitionFromTop
//        self.channelList.tableView.hidden=(!isChannelMode)
////        self.channelList.view.hidden=(!isChannelMode)
//        self.channelList.tableView.layer?.addAnimation(transitionChannelList, forKey: "animation")
//        
//        
        
        
        
    }
    func tableViewSelectionIsChanging(aNotification: NSNotification){
        let tableView=aNotification.object as! NSTableView
        let index=tableView.selectedRow
        _selectIndex=index
        let model=self._muarray_musicModel[index] as MusicModel
        self.p_playMusicWithNSUrl(model,index:index);
    }
    func p_playMusicWithNSUrl(model:MusicModel?,index:Int){
        self.musicListTableView.selectRowIndexes(NSIndexSet(index: index), byExtendingSelection:false)
        let musicUrl=NSURL(string:model!.url);
        
        self.titleLabel!.stringValue=model!.title+"/"+model!.albumtitle
//        dispatch_async(dispatch_get_main_queue()) {
//        })
        self._player?.stop()
        dispatch_async(dispatch_get_main_queue(), {
            
            self._player=NSSound(contentsOfURL:musicUrl!,byReference:true)
            
//            dispatch_async(dispatch_get_main_queue(), {
                //这里返回主线程，写需要主线程执行的代码
                self._player?.play()
                self.swithchPlayButtonState(true)
//            })
        })
//        dispatch_async(dispatch_get_main_queue()) {
//        })
        self.imageView.downloadImageFromURL(model!.picture)
    }
    override  func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
    }
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView?{
        let tableCellView=tableView.makeViewWithIdentifier("SongCell", owner: self) as! NSTableCellView
        
        tableCellView.layer?.backgroundColor=NSColor.grayColor().CGColor
        let model=self._muarray_musicModel[row] as MusicModel
        tableCellView.textField?.stringValue=model.title
        
//        tableCellView.wantsLayer=true
        var color:NSColor?
        if row%2==0{
            color=NSColor.whiteColor()
        }else{
            color=NSColor(calibratedRed:0.908 ,green:0.940, blue:0.995, alpha:1.000)
        }
        tableCellView.layer?.backgroundColor=color!.CGColor
        return tableCellView
    }

    func swithchPlayButtonState(isPlaying:Bool){
        if isPlaying{
            self.stopButton.hidden=false;
            self.playButton.hidden=true;
        }else{
            self.stopButton.hidden=true;
            self.playButton.hidden=false;

        }
    }
}

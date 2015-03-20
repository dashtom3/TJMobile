//
//  ViewController.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/18.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MasterViewDelegate,LeftViewDelegate,NewsViewDelegate,UIActionSheetDelegate{
    
    
    var leftView = LeftView()
    var masterView = MasterView()
    var newsView = NewsView()
    var viewState = false
    var pointLeftX  = CGFloat()
    var pointRightX  = CGFloat()
    var LEFT_FRAME = viewFrame(firstFrame: CGRectZero, secondFrame: CGRectZero)
    var RIGHT_FRAME = viewFrame(firstFrame: CGRectZero, secondFrame: CGRectZero)
    var numSelected = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        LEFT_FRAME = viewFrame(firstFrame: CGRectMake(-self.view.frame.width+48,0,self.view.frame.width-48,self.view.frame.height), secondFrame: CGRectMake(0,0,self.view.frame.width-48,self.view.frame.height))
        RIGHT_FRAME = viewFrame(firstFrame: CGRectMake(0,0,self.view.frame.width,self.view.frame.height), secondFrame: CGRectMake(self.view.frame.width-48,0,self.view.frame.width,self.view.frame.height))
        
        leftView = NSBundle.mainBundle().loadNibNamed("LeftView", owner: nil, options: nil)[0] as LeftView
        leftView.frame = LEFT_FRAME.firstFrame
        leftView.alpha = 0.0
        leftView.delegate = self
        //leftView.frame = CGRectMake(0,0,550,self.view.frame.height)
        self.view.addSubview(leftView)
        masterView = NSBundle.mainBundle().loadNibNamed("MasterView", owner: nil, options: nil)[0] as MasterView
        masterView.frame = RIGHT_FRAME.firstFrame
        masterView.delegate = self
        self.view.addSubview(masterView)
        newsView = NSBundle.mainBundle().loadNibNamed("NewsView", owner: nil, options: nil)[0] as NewsView
        newsView.frame = RIGHT_FRAME.firstFrame
        newsView.delegate = self
        self.view.addSubview(newsView)
        self.view.bringSubviewToFront(masterView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        self.refresh()
        leftView.refresh()

    }
    override func viewDidAppear(animated: Bool) {
        leftView.alpha = 1.0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refresh(){
        masterView.refresh()
    }
    func showLeftView() {
        if(masterView.center.x-masterView.frame.width/2==0){
            LeftAnimation(1)
        }else if(leftView.center.x-leftView.frame.width/2==0){
            LeftAnimation(0)
        }
    }
    func showMasterView(num:Int){
        switch num{
        case 0:
            masterView.alpha = 1
            newsView.alpha = 0
            showLeftView()
            break
        case 1:
            masterView.alpha = 0
            newsView.alpha = 1
            showLeftView()
            break
        default:
            masterView.alpha = 1
            newsView.alpha = 0
            showLeftView()
            break
        }
    }
    func presentUserViewController() {
        self.presentViewController(self.storyboard?.instantiateViewControllerWithIdentifier("user") as UserViewController, animated: true, completion: nil)
    }
    func showLoginViewController(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func pushViewController(num: Int) {
        numSelected = num
        switch num{
        case 0:
            var userDefault = NSUserDefaults.standardUserDefaults()
            if((userDefault.objectForKey("login") as NSString) == "0"){
                var alert = UIAlertView(title: "", message: "用户未登录，无法使用该功能", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                self.refresh()
            }else{
                self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("bus") as BusMainViewController, animated: true)
            }
            break
        case 1:
            var actionSheet = UIActionSheet(title: cards[num].labelName, delegate: self, cancelButtonTitle: "取 消", destructiveButtonTitle: nil, otherButtonTitles: "主 页", "微 信","微 博","掌上图书馆")
            actionSheet.showInView(self.view)
            break
        case 2:
            var actionSheet = UIActionSheet(title: cards[num].labelName, delegate: self, cancelButtonTitle: "取 消", destructiveButtonTitle: nil, otherButtonTitles: "主 页","微 信", "微 博")
            actionSheet.showInView(self.view)
            break
        case 3:
            if(UIApplication.sharedApplication().canOpenURL(NSURL(string: "emobile://")!)){
                UIApplication.sharedApplication().openURL(NSURL(string: "emobile://")!)
            }else{
                var url = NSURL(string: "http://www.weaver.com.cn/emobile")
                UIApplication.sharedApplication().openURL(url!)
            }
            self.refresh()
            break
        case 4:
            var actionSheet = UIActionSheet(title: cards[num].labelName, delegate: self, cancelButtonTitle: "取 消", destructiveButtonTitle: nil, otherButtonTitles: "主 页", "微 博")
            actionSheet.showInView(self.view)
            break
        case 5:
            var alert = UIAlertView(title: "青春同济微信号", message: "qctjwx", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            self.refresh()
        default:
            break
        }
        
    }
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch numSelected{
        case 1:
            if(buttonIndex == 1){
                var url = NSURL(string: "http://www.lib.tongji.edu.cn/site/tongji/index.html")
                UIApplication.sharedApplication().openURL(url!)
            }else if(buttonIndex == 2){
                var alert = UIAlertView(title: "微信号", message: "tongjilib", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                self.refresh()
            }else if(buttonIndex == 3){
                var url = NSURL(string: "http://weibo.com/tongjiunivlibrary")
                UIApplication.sharedApplication().openURL(url!)
            }else if(buttonIndex == 4){
                var url = NSURL(string: "http://www.lib.tongji.edu.cn/m/index.action")
                UIApplication.sharedApplication().openURL(url!)
            }
            break
        case 2:
            if(buttonIndex == 1){
                var url = NSURL(string: "http://www.tongjiren.org/")
                UIApplication.sharedApplication().openURL(url!)
            }else if(buttonIndex == 2){
                var alert = UIAlertView(title: "微信号", message: "TONGJI-xyh", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                self.refresh()
            }else if(buttonIndex == 3){
                var url = NSURL(string: "http://weibo.com/tongjiren")
                UIApplication.sharedApplication().openURL(url!)
            }
            break
        case 4:
            if(buttonIndex == 1){
                var url = NSURL(string: "http://www.tongji.edu.cn/")
                UIApplication.sharedApplication().openURL(url!)
            }else if(buttonIndex == 2){
                var url = NSURL(string: "http://weibo.com/tongjiuniversity")
                UIApplication.sharedApplication().openURL(url!)
            }
            break
        default:
            break
        }
        if(buttonIndex == 0){
            self.refresh()
        }
    }
    @IBAction func panGesture(sender: AnyObject) {
        if(sender.state == UIGestureRecognizerState.Began){
            pointLeftX = leftView.center.x-sender.locationInView(self.view).x
            pointRightX = masterView.center.x - sender.locationInView(self.view).x
        }
        if(sender.state == UIGestureRecognizerState.Changed){
            if(leftView.center.x-leftView.frame.width/2<=0&&leftView.center.x+leftView.frame.width/2>=0){
                if(pointLeftX+sender.locationInView(self.view).x+leftView.frame.width/2<0){
                    leftView.center = CGPointMake((-1)*(leftView.frame.width/2),leftView.center.y)
                    masterView.center = CGPointMake(masterView.frame.width/2, masterView.center.y)
                    newsView.center = masterView.center
                }else if(pointLeftX+sender.locationInView(self.view).x-leftView.frame.width/2>0){
                    leftView.center = CGPointMake(leftView.frame.width/2,leftView.center.y)
                    masterView.center = CGPointMake(leftView.frame.width+masterView.frame.width/2,masterView.center.y)
                    newsView.center = masterView.center
                }else{
                    leftView.center = CGPointMake(pointLeftX+sender.locationInView(self.view).x,leftView.center.y)
                    masterView.center = CGPointMake(pointRightX+sender.locationInView(self.view).x, masterView.center.y)
                    newsView.center = masterView.center
                }
            }
        }
        if(sender.state == UIGestureRecognizerState.Ended){
            if(leftView.center.x<0){
                LeftAnimation(0)
            }else{
                LeftAnimation(1)
            }
        }
    }
    func LeftAnimation(num:Int){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        UIView.setAnimationDelegate(self)
        if(num==0){
            leftView.frame = LEFT_FRAME.firstFrame
            masterView.frame = RIGHT_FRAME.firstFrame
            newsView.frame = RIGHT_FRAME.firstFrame
        }else if(num==1){
            leftView.frame = LEFT_FRAME.secondFrame
            masterView.frame = RIGHT_FRAME.secondFrame
            newsView.frame = RIGHT_FRAME.secondFrame
        }
        UIView.commitAnimations()
    }
}


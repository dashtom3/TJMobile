//
//  WaitingAnimation.swift
//  TJMobile
//
//  Created by 田程元 on 15/2/24.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit

class WaitingAnimation: UIView {

    @IBOutlet weak var waitingActivity: UIActivityIndicatorView!
    @IBOutlet weak var waitingLabel: UILabel!
    var waiting = false
    var waitingTimer = NSTimer();
    var waitingLabelNum = 0;
    var waitingLabelKindNum = 0;
    var waitingLabelKind = ["登录","获取班次","预定车票","获取车票","获取校区列表"]
    var waitingLabelString = ["中","中.","中..","中..."]
    override func awakeFromNib() {
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 4.0
        waitingTimer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "waitingLabelAnimation", userInfo: nil, repeats: true)
    }
    func startAnimation(){
        waiting = true
        self.alpha = 0.6
        waitingTimer.fireDate = NSDate()
        waitingActivity.startAnimating()
    }
    func stopAnimation(){
        waiting = false
        self.alpha = 0.0
        waitingTimer.fireDate = NSDate.distantFuture() as! NSDate
        waitingActivity.stopAnimating()
    }
    func waitingLabelAnimation(){
        waitingLabel.text = waitingLabelKind[waitingLabelKindNum]+waitingLabelString[waitingLabelNum]
        if(waitingLabelNum>=3){
            waitingLabelNum=0
        }else{
            waitingLabelNum++
        }
    }
}

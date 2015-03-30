//
//  UICopyLabel.swift
//  TJMobile
//
//  Created by 田程元 on 15/3/30.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit

class UICopyLabel: UILabel {
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib(){
        super.awakeFromNib()
        self.attachTapHandler()
    }
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return (action == Selector("copy:"))
    }
    override func copy(sender: AnyObject?) {
        var pboard = UIPasteboard.generalPasteboard()
        pboard.string = self.text
    }
    func attachTapHandler(){
        self.userInteractionEnabled = true
        var touch:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        self.addGestureRecognizer(touch)
    }
    func handleTap(recognizer:UIGestureRecognizer){
        self.becomeFirstResponder()
        var copyLink = UIMenuItem(title: "", action: Selector("copy:"))
        //UIMenuController.sharedMenuController().menuItems = NSArray(object:copyLink)
        UIMenuController.sharedMenuController().setTargetRect(self.frame, inView: self.superview!)
        UIMenuController.sharedMenuController().setMenuVisible(true, animated: true)
    }
}

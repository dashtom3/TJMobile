//
//  LoginView.swift
//  TJMobile
//
//  Created by 田程元 on 15/2/15.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit
protocol UserLoginDelegate:NSObjectProtocol{
    func loginShow();
    func back();
}
class LoginView: UIView {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    var delegate :UserLoginDelegate?
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
        password.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor")
        password.placeholderRectForBounds(CGRectMake(password.bounds.origin.x+100, password.bounds.origin.y, password.bounds.size.width-100, password.bounds.size.height))
        username.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor")
        username.placeholderRectForBounds(CGRectMake(username.bounds.origin.x+100, username.bounds.origin.y, username.bounds.size.width-100, username.bounds.size.height))
        
    }
    @IBAction func login(sender: AnyObject) {
        delegate?.loginShow()
    }
    @IBAction func back(sender: AnyObject) {
        delegate?.back();
    }
    @IBAction func inputUserBegin(sender: AnyObject) {
        username.textAlignment = NSTextAlignment.Left
    }
    @IBAction func inputPasswordBegin(sender: AnyObject) {
        password.textAlignment = NSTextAlignment.Left
    }
    @IBAction func inputUserEnd(sender: AnyObject) {
        username.textAlignment = NSTextAlignment.Center
    }
    @IBAction func inputPasswordEnd(sender: AnyObject) {
        password.textAlignment = NSTextAlignment.Center
    }
    override func drawRect(rect: CGRect) {
        var context:CGContextRef = UIGraphicsGetCurrentContext();
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 1)
        CGContextSetLineWidth(context, 0.5)
        CGContextMoveToPoint(context, 0, 100);
        CGContextAddLineToPoint(context, self.frame.size.width,100);
        CGContextMoveToPoint(context, 0, 148);
        CGContextAddLineToPoint(context, self.frame.size.width,148);
        CGContextMoveToPoint(context, 0, 229);
        CGContextAddLineToPoint(context, self.frame.size.width,229);
        CGContextMoveToPoint(context, 0, 277);
        CGContextAddLineToPoint(context, self.frame.size.width,277);
        CGContextStrokePath(context);
    }
}

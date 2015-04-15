//
//  LoginUserViewController.swift
//  TJMobile
//
//  Created by 田程元 on 15/1/30.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit

class LoginUserViewController: UIViewController,UserLoginDelegate,HttpDelegate {
    var loginView = LoginView()
    var waitingView = WaitingAnimation()
    var httpRequest = HttpRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView = NSBundle.mainBundle().loadNibNamed("LoginView", owner: nil, options: nil)[0] as! LoginView
        loginView.delegate = self
        loginView.frame = self.view.frame
        self.view.addSubview(loginView)
        waitingView = NSBundle.mainBundle().loadNibNamed("WaitingAnimation", owner: nil, options: nil)[0] as! WaitingAnimation
        waitingView.frame.origin.x = self.view.frame.width/2-80
        waitingView.frame.origin.y = self.view.frame.height/2-80
        waitingView.alpha = 0.0
        self.view.addSubview(waitingView)
        httpRequest.delegate = self
    }
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.loginView.username.becomeFirstResponder()
            self.loginView.layoutIfNeeded()
            }, completion: {finished in
        })
    }
    func loginShow() {
        loginView.username.resignFirstResponder()
        loginView.password.resignFirstResponder()
        waitingView.startAnimation()
        //httpRequest.servletLoginUser(loginView.username.text, password: loginView.password.text, weekend: "0")
        if(!httpRequest.servletISLogin(loginView.username.text, password: loginView.password.text)){
            infoReturn(0)
        }
    }
    func back() {
        //self.navigationController?.popViewControllerAnimated(true)
        self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("master") as! ViewController, animated: true)
    }
    func infoReturn(recallNum:Int){
        switch recallNum{
        case 0:
            var error:NSError?
            //userInfo = NSJSONSerialization.JSONObjectWithData(httpRequest.receiveDate, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
            var range = httpRequest.receiveStr.rangeOfString("id=\"UMUserProfile.tiledAttrs[9].ccActionValue.fldValue\" value=\"")
            if(range.length>0){
                var subString = httpRequest.receiveStr.substringFromIndex(range.location+range.length) as NSString
                var range2 = subString.rangeOfString("\"")
                var subString2 = subString.substringToIndex(range2.location)
                var userDefault = NSUserDefaults.standardUserDefaults()
                userDefault.setObject(subString2, forKey: "userInfo")
                userDefault.setObject(loginView.username.text, forKey: "username")
                userDefault.setObject(loginView.password.text, forKey: "password")
                userDefault.setObject("1", forKey: "login")
                waitingView.stopAnimation()
                self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("master") as! ViewController, animated: true)
            }else{
                var range = httpRequest.receiveStr.rangeOfString("UMUserPage?")
                if(range.length>0){
                    var subString = httpRequest.receiveStr.substringFromIndex(range.location+range.length) as NSString
                    var range2 = subString.rangeOfString("\"")
                    var subString2 = subString.substringToIndex(range2.location)
                    httpRequest.servletLoginPage2(subString2)
                }else{
                    if(httpRequest.receiveStr.rangeOfString("Authentication failed").length>0 || httpRequest.receiveStr.rangeOfString("验证失败。").length>0){
                        var alert = UIAlertView(title: "用户或密码错误", message: "", delegate: self, cancelButtonTitle: "确定")
                        alert.tag = 1
                        alert.show()
                        waitingView.stopAnimation()
                        
                    }else{
                        httpRequest.servletLoginPage()
                    }
                }
            }
            break
        default:
            var alert = UIAlertView(title: "网络连接失败", message: "", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            waitingView.stopAnimation()
            break
        }
    }
}

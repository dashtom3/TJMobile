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
        loginView = NSBundle.mainBundle().loadNibNamed("LoginView", owner: nil, options: nil)[0] as LoginView
        loginView.delegate = self
        loginView.frame = self.view.frame
        self.view.addSubview(loginView)
        waitingView = NSBundle.mainBundle().loadNibNamed("WaitingAnimation", owner: nil, options: nil)[0] as WaitingAnimation
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
        httpRequest.servletLoginUser(loginView.username.text, password: loginView.password.text, weekend: "0")
    }
    func back() {
        //self.navigationController?.popViewControllerAnimated(true)
        self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("master") as ViewController, animated: true)
    }
    func infoReturn(recallNum:Int){
        switch recallNum{
        case 0:
            if(httpRequest.receiveStr.length<5){
                var alert = UIAlertView(title: "用户、密码不对", message: "", delegate: self, cancelButtonTitle: "确定")
                alert.tag = 1
                alert.show()
                waitingView.stopAnimation()
            }else{
                var error:NSError?
                userInfo = NSJSONSerialization.JSONObjectWithData(httpRequest.receiveDate, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                var userDefault = NSUserDefaults.standardUserDefaults()
                userDefault.setObject(userInfo, forKey: "userInfo")
                userDefault.setObject(loginView.username.text, forKey: "username")
                userDefault.setObject(loginView.password.text, forKey: "password")
                userDefault.setObject("1", forKey: "login")
                var alert = UIAlertView(title: userInfo.valueForKey("name") as NSString, message: "登陆成功", delegate: self, cancelButtonTitle: "确定")
                alert.tag = 2
                alert.show()
                routeList = userInfo.valueForKey("routelist") as NSArray
                var nsDictionary:NSDictionary
                for nsDictionary in routeList{
                    for(var i = 0; i < SCHOOL.count;i++){
                        if(SCHOOL[i]==nsDictionary.valueForKey("start") as NSString){
                            for(var j = 0; j < SCHOOL.count;j++){
                                if(SCHOOL[j]==nsDictionary.valueForKey("end") as NSString){
                                    routeMatrix[i][j] = nsDictionary.valueForKey("route_id") as Int
                                    routeMatrix[i][i] = 1
                                }
                            }
                        }
                    }
                }
                waitingView.stopAnimation()
                self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("master") as ViewController, animated: true)
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

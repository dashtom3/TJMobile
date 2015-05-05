//
//  HttpRequest.swift
//  TJMobile_IOS
//
//  Created by 田程元 on 14/12/4.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit
protocol HttpDelegate:NSObjectProtocol{
    //0 用户登录
    func infoReturn(recallNum:Int)
}
class HttpRequest: NSObject,NSURLConnectionDelegate,NSURLConnectionDataDelegate{
    var basicUrl = "http://jiading.tongji.edu.cn:8080/TJbus/"
    var receiveDate = NSMutableData()
    var list = NSDictionary()
    var delegate:HttpDelegate?
    var receiveStr = NSString()
    func getRequest(url:NSString){
        var url = NSURL(string: url as String)
        var req = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
        var connection = NSURLConnection(request: req, delegate: self)
        
    }
    //注册用户
    //http://localhost:8080/TJbus/RegisterServlet?username=1333793&password=123&phone=18767122182
    func servletRegisterUser(username:NSString,password:NSString,phone:NSString){
        var url = basicUrl+"RegisterServlet?username="+(username as String)+"&password="+(password as String)+"&phone="+(phone as String)
        println("http发送请求:"+url)
        getRequest(url)
    }
    //激活用户
    //http://localhost:8080/TJbus/ActiveServlet?username=1333793
    func servletActiveUser(username:NSString){
        var url = basicUrl+"ActiveServlet?username="+(username as String)
        println("http发送请求:"+url)
        getRequest(url)
    }
    //登录用户
    func servletLoginUser(username:NSString,password:NSString,weekend:NSString){
        var url = basicUrl+"LoginServlet?username="+(username as String)+"&password="+(password as String)+"&weekend="+(weekend as String)
        println("http发送请求:"+url)
        getRequest(url)
    }
    func servletLoginSelf(){
        //var url = basicUrl+"LoginServlet?username=1336313&password=504083&weekend=0"
        var url = "http://jiading.tongji.edu.cn:8080/TJbus2/BusServlet"
        println("http发送请求:"+url)
        getRequest(url)
    }
    //密码找回
    //异步取回姓名
    //查询线下所有班车信息
    func servletGetBus(route_id:NSString,admin:NSString){
        var url = basicUrl+"GetBusServlet?route_id="+(route_id as String)+"&admin="+(admin as String)
        println("http发送请求:"+url)
        getRequest(url)
    }
    //查询所有路线
    func servletGetAllServlet(){
        var url = basicUrl+"LoginServlet"
        getRequest(url)
    }
    //抢票
    func servletBookTicket(username:NSString,ticket_time:NSString,bus_id:NSString){
        var url = basicUrl+"getTicketServlet?username="+(username as String)+"&get_ticket_time="+(ticket_time as String)+"&bus_id="+(bus_id as String)
        println("http发送请求:"+url)
        getRequest(url)
    }
    func servletGetTicket(username:NSString,curtime:NSString,history:NSString){
        var url = basicUrl+"TicketServlet?username="+(username as String)+"&curtime="+(curtime as String)+"&history="+(history as String)
        println("http发送请求:"+url)
        getRequest(url)
    }
    func ticketUrl(username:NSString,curtime:NSString,history:NSString)->NSString{
        return basicUrl+"TicketServlet?username="+(username as String)+"&curtime="+(curtime as String)+"&history="+(history as String)
    }
    //退票
    func servletCancelTicket(ticket_id:NSString,bus_id:NSString){
        var url = basicUrl+"CancelTicketServlet?ticket_id="+(ticket_id as String)+"&bus_id="+(bus_id as String)
        println("http发送请求:"+url)
        getRequest(url)
    }
    //统一身份认证
    func servletISLogin(username:NSString,password:NSString)->Bool{
        var url = "http://tjis2.tongji.edu.cn:58080/amserver/UI/Login?Login.Token1="+(username as String)+"&Login.Token2="+(password as String)+"&gx_charset=UTF-8"
        if((NSURL(string: url)) != nil){
            var req = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
            req.HTTPMethod = "POST"
            var connection = NSURLConnection(request: req, delegate: self)
            return true
        }
        receiveStr = "Authentication failed"
        return false
    }
    func servletLoginPage(){
        var url = "http://tjis2.tongji.edu.cn:58080/amconsole/base/AMAdminFrame"
        var req = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
        var connection = NSURLConnection(request: req, delegate: self)
    }
    func servletLoginPage2(cookie:NSString){
        var url = "http://tjis2.tongji.edu.cn:58080/amconsole/user/UMUserPage?"+(cookie as String)
        var req = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
//        var header  = NSMutableDictionary()
//        header.setValue("application/x-www-form-urlencoded; charset=utf-8", forKey: "Content-Type")
//        header.setValue("text/html", forKey:"Accept")
//        header.setValue("no-cache" ,forKey:"Cache-Control")
//        header.setValue("no-cache", forKey:"Pragma")
//        header.setValue("close", forKey:"Connection")
//        req.allHTTPHeaderFields = header
        var connection = NSURLConnection(request: req, delegate: self)
    }
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        delegate?.infoReturn(-1)
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        receiveDate.appendData(data)
        //println(receiveDate)
    }
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        receiveDate = NSMutableData()
    }
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        receiveStr = NSString(data: receiveDate, encoding: NSUTF8StringEncoding)!
        println(receiveStr)
        delegate?.infoReturn(0)
    }
}

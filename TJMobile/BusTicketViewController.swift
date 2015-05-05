//
//  BusTicketViewController.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/23.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class BusTicketViewController: UIViewController,HttpDelegate {

    @IBOutlet weak var labelLine: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var qrCode: UIImageView!
    var waitingView = WaitingAnimation()
    var httpRequest = HttpRequest()
    var styleNum = -1;
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBtn.layer.cornerRadius = 4
        okBtn.layer.cornerRadius = 4
        self.setStyle(styleNum)
        waitingView = NSBundle.mainBundle().loadNibNamed("WaitingAnimation", owner: nil, options: nil)[0] as! WaitingAnimation
        waitingView.frame.origin.x = self.view.frame.width/2-80
        waitingView.frame.origin.y = self.view.frame.height/2-80
        waitingView.alpha = 0.0
        waitingView.waitingLabelKindNum = 2;
        self.view.addSubview(waitingView)
        httpRequest.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func backBusMainView(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func clickCancelBtn(sender: AnyObject) {
        for viewController:AnyObject in (self.navigationController?.viewControllers)!{
            if(viewController.isKindOfClass(BusMainViewController)){
                self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
            }
        }
    }
    
    @IBAction func clickOKBtn(sender: AnyObject) {
        waitingView.startAnimation()
        var userDefault = NSUserDefaults.standardUserDefaults()
        if(okBtn.titleLabel?.text == "确认预约"){
        httpRequest.servletBookTicket(userDefault.objectForKey("username") as! NSString, ticket_time: "10000", bus_id: routeLine.objectAtIndex(selectNum[2]).valueForKey("bus_id") as! NSString)
        }else if (okBtn.titleLabel?.text == "取消凭证"){
            httpRequest.servletCancelTicket(TICKET.tickets[styleNum].ticket_id, bus_id: TICKET.tickets[styleNum].bus_id)
        }
        //self.navigationController?.popToViewController(self.navigationController?.viewControllers[2] as UIViewController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func infoReturn(recallNum: Int) {
        
        switch recallNum{
        case 0:
            var error:NSError?
            NSLog("%@", httpRequest.receiveStr)
            var receiveData :NSString = httpRequest.receiveStr.substringToIndex(1)
            if(styleNum == -1){
            if(receiveData == "0"){
                var receiveData2 :NSString = httpRequest.receiveStr.substringWithRange(NSMakeRange(2, 1))
                if(receiveData2 == "0"){
                    var alert = UIAlertView(title: "没有空位", message: "", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                        if(viewController.isKindOfClass(BusMainViewController)){
                            self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                        }
                    }
                }else if(receiveData2 == "1"){
                    var alert = UIAlertView(title: "已订票,不能再抢", message: "", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                        if(viewController.isKindOfClass(BusMainViewController)){
                            self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                        }
                    }
                }else if(receiveData2 == "2"){
                    var alert = UIAlertView(title: "抢票机会已无", message: "", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                        if(viewController.isKindOfClass(BusMainViewController)){
                            self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                        }
                    }
                }else if(receiveData2 == "3"){
                    var alert = UIAlertView(title: "所有抢票机会已无，回程票已抢好", message: "", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                        if(viewController.isKindOfClass(BusMainViewController)){
                            self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                        }
                    }
                }
            }else if(receiveData.substringToIndex(1) == "1"){
                var alert = UIAlertView(title: "订票成功", message: "", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                    if(viewController.isKindOfClass(BusMainViewController)){
                        self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                    }
                }
            }else if(receiveData.substringToIndex(1) == "2"){
                var alert = UIAlertView(title: "回程票预定成功", message: "", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                    if(viewController.isKindOfClass(BusMainViewController)){
                        self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                    }
                }
            }else if(receiveData.substringToIndex(1) == "3"){
                var alert = UIAlertView(title: "抢票时间已过", message: "请在06:00到24:00之间抢票", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                    if(viewController.isKindOfClass(BusMainViewController)){
                        self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                    }
                }
            }
            }else{
                if(receiveData == "0"){
                    var alert = UIAlertView(title: "退票失败", message: "", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                        if(viewController.isKindOfClass(BusMainViewController)){
                            self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                        }
                    }
                }else if(receiveData == "1"){
                    var alert = UIAlertView(title: "退票成功", message: "", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                        if(viewController.isKindOfClass(BusMainViewController)){
                            self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                        }
                    }
                }else if(receiveData == "2"){
                    var alert = UIAlertView(title: "非退票时间", message: "订票当天22点前", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    for viewController:AnyObject in (self.navigationController?.viewControllers)!{
                        if(viewController.isKindOfClass(BusMainViewController)){
                            self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
                        }
                    }
                    
                }
            }
            waitingView.stopAnimation()
            break
        default:
            var alert = UIAlertView(title: "网络连接失败", message: "", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            waitingView.stopAnimation()
            break
        }
        
    }
    func setStyle(num:Int){
        var dateConverter = DateConverter()
        var ticket:String
        if(num == -1){
            labelLine.attributedText = stringChange(SCHOOL[selectNum[0]], busTo: SCHOOL[selectNum[1]])
            labelTime.text = (routeLine.objectAtIndex(selectNum[2]) as! NSDictionary).valueForKey("time") as! NSString as String
            var tomorrowDate = NSDate(timeIntervalSinceNow: NSTimeInterval(86400))
            
            var dayString = (dateConverter.getMMFromDate(tomorrowDate) as String)+"月"+(dateConverter.getddFromDate(tomorrowDate) as String)+"日 "+(dateConverter.getDayFromDate(tomorrowDate) as String)
            labelDay.text = dayString
            okBtn.setTitle("确认预约", forState:UIControlState.Normal)
            cancelBtn.alpha = 1.0
            ticket = "  时间:"+labelDay.text!+" "+labelTime.text!+" 车票信息:"+SCHOOL[selectNum[0]]+"到"+SCHOOL[selectNum[1]]
        }else{
            labelLine.attributedText = stringChange(TICKET.tickets[num].busFrom,busTo:TICKET.tickets[num].busTo)
            var dateBooked = dateConverter.getDateFromNSString(TICKET.tickets[num].time)
            labelTime.text = dateConverter.getHHmmFromDate(dateBooked) as String
            labelDay.text = (dateConverter.getMMFromDate(dateBooked) as String)+"月"+(dateConverter.getddFromDate(dateBooked) as String)+"日 "+(dateConverter.getDayFromDate(dateBooked) as String)
            okBtn.setTitle("取消凭证", forState:UIControlState.Normal)
            cancelBtn.alpha = 0.0
            ticket = "  时间:"+labelDay.text!+" "+labelTime.text!+" 车票信息:"+(TICKET.tickets[num].busFrom as String)+"到"+(TICKET.tickets[num].busTo as String)
        }
        var strVal = "学号:"+(NSUserDefaults.standardUserDefaults().valueForKey("username") as! String)+" 姓名:"+(NSUserDefaults.standardUserDefaults().valueForKey("userInfo") as! String)
        
        qrCode.image = UIImage(CIImage:UIImage.createQRCodeImage(strVal+ticket))
    }
    func stringChange(busFrom:NSString,busTo:NSString)->NSMutableAttributedString{
        var str:NSMutableAttributedString = NSMutableAttributedString(string: "从"+(busFrom as String)+"到"+(busTo as String))
        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(1,busFrom.length))
        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(str.length-busTo.length,busTo.length))
        return str
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

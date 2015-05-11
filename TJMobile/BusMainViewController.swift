//
//  BusMainViewController.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/22.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class BusMainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HttpDelegate,PickerViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    let labelTableView = ["常住校区","如何预约","如何预约"]
    var waitingView = WaitingAnimation()
    var httpRequest = HttpRequest()
    var select = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "BusTicketCell", bundle: nil), forCellReuseIdentifier: "BusCell")
        tableView.registerNib(UINib(nibName: "UserPickerViewCell", bundle: nil), forCellReuseIdentifier: "PickerCell")
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 0.01))
        tableView.backgroundColor = UIColor.clearColor()
        //tableView.contentInset.top = -20
        self.edgesForExtendedLayout = UIRectEdge.allZeros
        waitingView = NSBundle.mainBundle().loadNibNamed("WaitingAnimation", owner: nil, options: nil)[0] as! WaitingAnimation
        waitingView.frame.origin.x = self.view.frame.width/2-80
        waitingView.frame.origin.y = self.view.frame.height/2-80
        waitingView.alpha = 0.0
        
        self.view.addSubview(waitingView)
        httpRequest.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
        tableView.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        waitingView.startAnimation()
        waitingView.waitingLabelKindNum = 4;
        httpRequest.servletLoginSelf()
        //httpRequest.servletGetTicket(userDefault.objectForKey("username") as NSString, curtime: NSString(format: "%d", Int(NSTimeIntervalSince1970)) , history: "0")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backMainView(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func infoReturn(recallNum: Int) {
                switch recallNum{
                case 0:
                    if(waitingView.waitingLabelKindNum == 4){
                    if(httpRequest.receiveStr.length<5){
                        var alert = UIAlertView(title: "获取列表出现问题", message: "", delegate: self, cancelButtonTitle: "确定")
                        alert.tag = 1
                        alert.show()
                        waitingView.stopAnimation()
                    }else{
                        var error:NSError?
                        //userInfo = NSJSONSerialization.JSONObjectWithData(httpRequest.receiveDate, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                        //routeList = userInfo.valueForKey("routelist") as NSArray
                        var userInfo = NSJSONSerialization.JSONObjectWithData(httpRequest.receiveDate, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
                        var nsDictionary:NSDictionary
                        for nsDictionary in userInfo{
                            for(var i = 0; i < SCHOOL.count;i++){
                                var name1 = nsDictionary.valueForKey("start") as? NSString
                                if(nsDictionary.valueForKey("start") as? NSString=="四平校区"){
                                    name1 = "四平路校区"
                                }
                                if(SCHOOL[i]==name1){
                                    for(var j = 0; j < SCHOOL.count;j++){
                                        var name2 = nsDictionary.valueForKey("end") as? NSString
                                        if(nsDictionary.valueForKey("end") as? NSString=="四平校区"){
                                            name2 = "四平路校区"
                                        }
                                        if(SCHOOL[j]==name2){
                                            routeMatrix[i][j] = nsDictionary.valueForKey("route_id") as! Int
                                            routeMatrix[i][i] = 1
                                        }
                                    }
                                }
                            }
                        }
                        waitingView.waitingLabelKindNum = 3;
                    httpRequest.servletGetTicket(NSUserDefaults.standardUserDefaults().objectForKey("username")as! NSString, curtime: NSString(format: "%d", Int(NSTimeIntervalSince1970)) , history: "0")
                    }
                    }else{
                        var error:NSError?
                        var tickets = NSJSONSerialization.JSONObjectWithData(httpRequest.receiveDate, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
                        var ticket = NSDictionary()
                        TICKET.tickets = []
                        TICKET.todayNum = 0;
                        for(var i = 0;i<tickets.count;i++){
                            var ticket:NSDictionary = tickets[i] as! NSDictionary
                            var from = ticket.valueForKey("start") as! NSString
                            var to = ticket.valueForKey("end") as! NSString
                            if(from=="四平校区"){
                                from = "四平路校区"
                            }
                            if(to=="四平校区"){
                                to = "四平路校区"
                            }
                            var dateConverter = DateConverter()
                            var timeDate = dateConverter.getDateStrFromDate(dateConverter.getDateFromNSString(ticket.valueForKey("ticket_time") as! NSString))
                            
                            var ticket2 = ticketInfo(time: timeDate, busFrom: from, busTo: to, bus_id: ticket.valueForKey("bus_id") as! NSString, ticket_id: NSString(format: "%d",ticket.valueForKey("id") as! Int))
                            
                            var dateBooked = dateConverter.getDateFromNSString(ticket2.time)
                            var day2 = dateConverter.getddFromDate(dateBooked)
                            var day = dateConverter.getddFromDate(NSDate(timeIntervalSinceNow: 3600*24))
                            if(day == day2){
                                TICKET.todayNum++;
                                TICKET.todayNumInTickets = i
                            }
                            TICKET.tickets.append(ticket2)
                        }
                        TICKET.num = tickets.count
                        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
                        waitingView.stopAnimation()
                    }
                    break
                default:
                    var alert = UIAlertView(title: "网络连接失败", message: "", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    waitingView.stopAnimation()
                    break
                }

    }
    func pickerOK(name: NSString) {
        var userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(name, forKey: "userPlace")
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 1)], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            if(TICKET.num == 0){
                return 1
            }else{
                //TODO 时间比对 预约返程班车
                if(TICKET.todayNum==1){
                    return TICKET.num+1
                }
                return TICKET.num
            }
        }
        if(section == 1){
            if(select == true){
                return 3
            }
            return 2
        }
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            if(indexPath.row == TICKET.num && TICKET.num != 0){
                return 46
            }
            return 84
        }
        if(indexPath.section == 1 && indexPath.row == 1 && select == true){
            return 102
        }
        return 46
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell()
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        var cell1 = tableView.dequeueReusableCellWithIdentifier("BusCell")as! BusTicketCell
        var pickerCell = tableView.dequeueReusableCellWithIdentifier("PickerCell") as! UserPickerViewCell
        if(indexPath.section == 0){
            if(indexPath.row == TICKET.num && TICKET.num != 0){
                var cell2 = tableView.dequeueReusableCellWithIdentifier("busAddCell") as! BusBackCell
                return cell2
            }
            cell1.setStyle(indexPath.row)
            return cell1
            
        }else if(indexPath.section == 1){
            if(select == true && indexPath.row == 1){
                pickerCell.delegate = self
                if((NSUserDefaults.standardUserDefaults().valueForKey("userPlace")) != nil){
                    pickerCell.setSelect(NSUserDefaults.standardUserDefaults().valueForKey("userPlace") as! NSString)
                }
                return pickerCell
            }
            cell.textLabel?.text = labelTableView[indexPath.row]
            if(indexPath.row==0){
                //TODO 得到常住校区
                if((NSUserDefaults.standardUserDefaults().valueForKey("userPlace")) != nil){
                    cell.detailTextLabel?.text = NSUserDefaults.standardUserDefaults().valueForKey("userPlace") as! NSString as String
                }else{
                    cell.detailTextLabel?.text = "四平路校区"
                }
                cell.detailTextLabel?.textColor = UIColor(red: 250/255, green: 157/255, blue: 76/255, alpha: 1)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
        }else if(indexPath.section == 2){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.text = "开始预约"
            //cell.textLabel?.textColor = UIColor(red: 255/255, green: 132/255, blue: 113/255, alpha: 1)
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if(indexPath.section == 0 && TICKET.num == 0 && indexPath.row == 0){
            return nil
        }
        return  indexPath
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(indexPath.section == 2){
            if((NSUserDefaults.standardUserDefaults().valueForKey("userPlace")) != nil){
                for(var i=0;i<SCHOOL.count;i++){
                    if((NSUserDefaults.standardUserDefaults().valueForKey("userPlace") as! NSString).isEqualToString(SCHOOL[i])){
                        selectNum[0] = i
                    }
                }
            }
            self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("busfrom") as! BusFromViewController , animated: true )
        }
        if(indexPath.section == 1){
            if(indexPath.row == 0){
                if(select == false){
                    select = true
                    tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
                }else{
                    select = false
                    tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            }
            var num = 0
            if(select == true){
                num++
            }
            if(indexPath.row - num == 1){
                self.presentViewController(self.storyboard?.instantiateViewControllerWithIdentifier("pagecontent") as! BusPageViewController, animated: true, completion: nil)
            }
        }
        if(indexPath.section == 0){
            if(indexPath.row == TICKET.num && TICKET.num != 0){
                selectNum[0]=inputSelectNum(TICKET.tickets[TICKET.todayNumInTickets].busTo)
                selectNum[1]=inputSelectNum(TICKET.tickets[TICKET.todayNumInTickets].busFrom)
                if(routeMatrix[selectNum[0]][selectNum[1]] == 0){
                    var alert = UIAlertView(title: "", message: "暂无返回车次", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                }else{
                    var busTimeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("bustime") as! BusTimeViewController
                    self.navigationController?.pushViewController(busTimeViewController, animated: true )
                }
            }else if(TICKET.num != 0){
                var busTicketViewController = self.storyboard?.instantiateViewControllerWithIdentifier("busticket") as! BusTicketViewController
                self.navigationController?.pushViewController(busTicketViewController, animated: true )
                busTicketViewController.styleNum = indexPath.row
            }
        }
    }
    func inputSelectNum(schoolName:NSString)->Int{
        for(var i = 0;i<SCHOOL.count;i++){
            if(SCHOOL[i] == schoolName){
                return i
            }
        }
        return 0
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

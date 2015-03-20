//
//  BusMainViewController.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/22.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class BusMainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HttpDelegate{
    @IBOutlet weak var tableView: UITableView!
    let labelTableView = ["常住校区","如何预约"]
    var waitingView = WaitingAnimation()
    var httpRequest = HttpRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "BusTicketCell", bundle: nil), forCellReuseIdentifier: "BusCell")
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 0.01))
        tableView.backgroundColor = UIColor.clearColor()
        //tableView.contentInset.top = -20
        self.edgesForExtendedLayout = UIRectEdge.allZeros
        waitingView = NSBundle.mainBundle().loadNibNamed("WaitingAnimation", owner: nil, options: nil)[0] as WaitingAnimation
        waitingView.frame.origin.x = self.view.frame.width/2-80
        waitingView.frame.origin.y = self.view.frame.height/2-80
        waitingView.alpha = 0.0
        waitingView.waitingLabelKindNum = 3;
        self.view.addSubview(waitingView)
        httpRequest.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
    }
    override func viewDidAppear(animated: Bool) {
        waitingView.startAnimation()
        var userDefault = NSUserDefaults.standardUserDefaults()
        httpRequest.servletGetTicket(userDefault.objectForKey("username") as NSString, curtime: NSString(format: "%d", Int(NSTimeIntervalSince1970)) , history: "0")
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
            var error:NSError?
            var tickets = NSJSONSerialization.JSONObjectWithData(httpRequest.receiveDate, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSArray
            var ticket = NSDictionary()
            TICKET.tickets = []
            for ticket in tickets{
                var ticket2 = ticketInfo(time: ticket.valueForKey("ticket_time") as NSString, busFrom: ticket.valueForKey("start") as NSString, busTo: ticket.valueForKey("end") as NSString, bus_id: ticket.valueForKey("bus_id") as NSString, ticket_id: NSString(format: "%d",ticket.valueForKey("id") as Int))
                TICKET.tickets.append(ticket2)
            }
            TICKET.num = tickets.count
            tableView.reloadData()
            waitingView.stopAnimation()
            break
        default:
            var alert = UIAlertView(title: "网络连接失败", message: "", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            waitingView.stopAnimation()
            break
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 3
    }
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView!, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            if(TICKET.num == 0){
                return 1
            }else{
                //TODO 时间比对 预约返程班车
                return TICKET.num
            }
        }
        if(section == 1){
            return 2
        }
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if(indexPath.section == 0){
            return 84
        }
        return 46
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell()
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        var cell1 = tableView.dequeueReusableCellWithIdentifier("BusCell") as BusTicketCell
        if(indexPath.section == 0){
            cell1.setStyle(indexPath.row)
            return cell1
        }else if(indexPath.section == 1){
            cell.textLabel?.text = labelTableView[indexPath.row]
            if(indexPath.row==0){
                //TODO 得到常住校区
                cell.detailTextLabel?.text = "四平路校区"
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
    
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if(indexPath.section == 2){
            self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("busfrom") as BusFromViewController , animated: true )
        }
        if(indexPath.section == 0){
            var busTicketViewController = self.storyboard?.instantiateViewControllerWithIdentifier("busticket") as BusTicketViewController
            self.navigationController?.pushViewController(busTicketViewController, animated: true )
            busTicketViewController.styleNum = indexPath.row
        }
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

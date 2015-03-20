//
//  BusTimeViewController.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/22.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class BusTimeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HttpDelegate {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var waitingView  =  WaitingAnimation()
    var httpRequest = HttpRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.allZeros
        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: "BusTicketCell", bundle: nil), forCellReuseIdentifier: "BusCell")
        tableView.registerNib(UINib(nibName: "BusTimeCell", bundle: nil), forCellReuseIdentifier: "BusTime")
        waitingView = NSBundle.mainBundle().loadNibNamed("WaitingAnimation", owner: nil, options: nil)[0] as WaitingAnimation
        waitingView.frame.origin.x = self.view.frame.width/2-80
        waitingView.frame.origin.y = self.view.frame.height/2-80
        waitingView.alpha = 0.0
        waitingView.waitingLabelKindNum = 1;
        self.view.addSubview(waitingView)
        httpRequest.delegate = self
    }
    override func viewDidAppear(animated: Bool) {
        //TODO 获取时间
        waitingView.startAnimation()
        httpRequest.servletGetBus(NSString(format: "%d", routeMatrix[selectNum[0]][selectNum[1]]), admin: "0")
    }
    @IBAction func backBusToView(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func infoReturn(recallNum: Int) {
        switch recallNum{
        case 0:
            var error:NSError?
            routeLine = NSJSONSerialization.JSONObjectWithData(httpRequest.receiveDate, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSArray
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
        return 1
    }
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView!, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeLine.count+1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if(indexPath.row==0){
            return 84
        }
        return 70
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("BusTime") as BusTimeCell
        var cell1 = tableView.dequeueReusableCellWithIdentifier("BusCell") as BusTicketCell
        if(indexPath.row == 0 ){
            cell1.setStyle(-1)
            return cell1
        }else{
            if((routeLine.objectAtIndex(indexPath.row-1) as NSDictionary).valueForKey("rest")?.intValue==0){
                cell.setStyle((routeLine.objectAtIndex(indexPath.row-1) as NSDictionary).valueForKey("time") as NSString, way: "预约已满")
            }else{
            cell.setStyle((routeLine.objectAtIndex(indexPath.row-1) as NSDictionary).valueForKey("time") as NSString, way: (routeLine.objectAtIndex(indexPath.row-1) as NSDictionary).valueForKey("line") as NSString)
            }
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as BusTimeCell
        if(cell.labelWay.text == "预约已满"){
            return nil
        }
        return indexPath
    }
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        selectNum[2] = indexPath.row-1
        self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("busticket") as BusTicketViewController, animated: true)
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

//
//  BusFromViewController.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/22.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class BusFromViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.allZeros
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        if(selectNum[0] == -1){
            nextBtn.enabled = false
        }else{
            nextBtn.enabled = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView!, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIView(frame: CGRectMake(0, 0, 220, 30))
        let title = UILabel(frame: CGRectMake(15, 0, 200, 30))
        title.backgroundColor = UIColor.clearColor()
        title.font = UIFont.systemFontOfSize(14)
        title.text = "选择出发校区"
        title.textColor = UIColor(red: 0, green: 173/255, blue: 255/255, alpha: 1)
        titleView.addSubview(title)
        return titleView
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 46
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell()
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.text = SCHOOL[indexPath.row]
        if(routeMatrix[indexPath.row][indexPath.row]==0){
            cell.contentView.alpha = 0.3
            cell.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 0.7)
        }else if(selectNum[0] == indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.textLabel?.textColor = UIColor(red: 250/255, green: 150/255, blue: 76/255, alpha: 1)
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if(routeMatrix[indexPath.row][indexPath.row] == 0){
            return nil
        }
        return indexPath
    }
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        selectNum[0]=indexPath.row
        for(var i = 0;i<5;i++){
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0))
            if(i==indexPath.row){
                cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                cell?.textLabel?.textColor = UIColor(red: 250/255, green: 150/255, blue: 76/255, alpha: 1)
            }else{
                cell?.accessoryType = UITableViewCellAccessoryType.None
                cell?.textLabel?.textColor = UIColor.blackColor()
            }
        }
        nextBtn.enabled = true
        
    }
    @IBAction func backBusMainView(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func pushBusToView(sender: AnyObject) {
        self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("busto") as BusToViewController, animated: true)
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

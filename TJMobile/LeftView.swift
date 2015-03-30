//
//  LeftView.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/18.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit
protocol LeftViewDelegate:NSObjectProtocol{
    func presentUserViewController()
    func showMasterView(num:Int)
    func showLoginViewController()
    func presentSettingViewController()
}
class LeftView: UIView,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var delegate:LeftViewDelegate?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    func refresh(){
        var userDefaults = NSUserDefaults.standardUserDefaults()
        var imageData:NSData? = userDefaults.valueForKey("userImage") as NSData?
        if(imageData?.length>0){
            userImage.image = (NSKeyedUnarchiver.unarchiveObjectWithData(imageData!) as UIImage)
        }
    }
    override func awakeFromNib() {
        tableView.registerNib(UINib(nibName: "LeftViewTableCell", bundle: nil), forCellReuseIdentifier: "LeftCell")
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = 50
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Top)
        var cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as LeftViewTableCell
        cell.labelName.textColor = UIColor(red: 255/255, green: 144/255, blue: 0/255, alpha: 1)
        self.refresh()
    }
    @IBAction func presentSettingView(sender: AnyObject) {
        delegate?.presentSettingViewController()
    }
    @IBAction func presentUserView(sender: AnyObject) {
        if(NSUserDefaults.standardUserDefaults().valueForKey("login") as NSString == "1"){
            delegate?.presentUserViewController()
        }else{
            delegate?.showLoginViewController()
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView!, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LEFT_LIST.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 46
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("LeftCell", forIndexPath: indexPath) as LeftViewTableCell
        cell.backgroundColor = UIColor.clearColor()
        cell.labelName.text = LEFT_LIST[indexPath.row]
        return cell
    }
    
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        for(var i=0;i<LEFT_LIST.count;i++){
            var cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as LeftViewTableCell
            if(indexPath.row == i){
               cell.labelName.textColor = UIColor(red: 255/255, green: 144/255, blue: 0/255, alpha: 1)
            }else{
                cell.labelName.textColor = UIColor.whiteColor()
            }
        }
        delegate?.showMasterView(indexPath.row)
    }
}

//
//  SettingViewController.swift
//  TJMobile
//
//  Created by 田程元 on 15/3/24.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit
import MessageUI
class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate{
    let names = ["关于 TJMobile","联系我们","评分"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
//        
//        return 70
//    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell()
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch indexPath.row{
        case 0:
            self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("about") as! AboutViewController, animated: true)
            break
        case 1:
            sendMail()
            break
        case 2:
            break
        default:
            break
        }
        //self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("busticket") as BusTicketViewController, animated: true)
    }
    func sendMail(){
        var mailPicker = MFMailComposeViewController()
        mailPicker.mailComposeDelegate = self
        mailPicker.setSubject("关于TJMobile意见与建议")

        mailPicker.setToRecipients(NSArray(object: "yun@tongji.edu.cn") as [AnyObject])
        mailPicker.setMessageBody("尊敬的TJMobile开发团队：", isHTML: true)
        self.presentViewController(mailPicker, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        switch result.value{
        case 0:
            break
        case 1:
            var alert = UIAlertView(title:"", message: "邮件保存成功", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            break
        case 2:
            var alert = UIAlertView(title:"", message: "邮件发送成功", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            break
        case 3:
            var alert = UIAlertView(title:"", message: "邮件发送失败", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            break
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

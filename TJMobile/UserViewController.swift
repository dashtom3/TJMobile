//
//  UserViewController.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/22.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //var title = ["常住校区","寝室","用户头像","封面","退出登录"]
    let userTitle = [["常住校区","寝室"],["用户头像","封面"],["退出登录"]]
    let detailTitle = ["四平路校区","西南八楼437"]

    @IBOutlet weak var userImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = 50
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        var imageData:NSData? = userDefaults.valueForKey("userImage") as NSData?
        if(imageData?.length>0){
            var image  = NSKeyedUnarchiver.unarchiveObjectWithData(imageData!) as UIImage
            userImage.setBackgroundImage(image, forState: UIControlState.Normal)
        }else{
            userImage.setBackgroundImage(UIImage(named: "user_pic"), forState: UIControlState.Normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func changePic(sender: AnyObject) {
        self.changePersonPic()
    }
    func changePersonPic(){
        var picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        var userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(NSKeyedArchiver.archivedDataWithRootObject(image), forKey: "userImage")
        userImage.imageView?.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
        if(section != 2){
            return 2
        }
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 46
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell()
        
        //cell.backgroundColor = UIColor.clearColor()
        //cell.labelName.text = LEFT_LIST[indexPath.row]
        
        if(indexPath.section == 0){
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.detailTextLabel?.text = detailTitle[indexPath.row]
            cell.detailTextLabel?.textColor = UIColor(red: 250/255, green: 157/255, blue: 76/255, alpha: 1)
        }else if(indexPath.section == 1){
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        }else if(indexPath.section == 2){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.textColor = UIColor(red: 255/255, green: 132/255, blue: 113/255, alpha: 1)
        }
        cell.textLabel?.text = userTitle[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if(indexPath.section == 2){
            NSUserDefaults.standardUserDefaults().setObject("0", forKey: "login")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

	//
//  UserViewController.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/22.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit
enum PIC{
    case PERSON
    case BACKGROUND
}
protocol popUserViewDelegate:NSObjectProtocol{
    func popUserViewController()
}
class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PickerViewDelegate {
    //var title = ["常住校区","寝室","用户头像","封面","退出登录"]
    var delegate:popUserViewDelegate?
    @IBOutlet weak var userName: UILabel!
    let userTitle = [["常住校区"],["用户头像","封面"],["退出登录"]]
    let detailTitle = ["四平路校区"]
    var changePic = PIC.PERSON
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var userBg: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var select = false
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = 50
        tableView.registerNib(UINib(nibName: "UserPickerViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "PickerCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        var imageData:NSData? = userDefaults.valueForKey("userImage") as NSData?
        var imageData2:NSData? = userDefaults.valueForKey("userBG") as NSData?
        if(imageData?.length>0){
            var image  = NSKeyedUnarchiver.unarchiveObjectWithData(imageData!) as UIImage
            userImage.setBackgroundImage(image, forState: UIControlState.Normal)
        }else{
            userImage.setBackgroundImage(UIImage(named: "user_pic"), forState: UIControlState.Normal)
        }
        if(imageData2?.length>0){
            var image  = NSKeyedUnarchiver.unarchiveObjectWithData(imageData2!) as UIImage
            userBg.setBackgroundImage(image, forState: UIControlState.Normal)
        }else{
            userBg.setBackgroundImage(UIImage(named: "user_bg"), forState: UIControlState.Normal)
        }
        userName.text = userDefaults.valueForKey("userInfo") as NSString
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func changeUserBG(sender: AnyObject) {
        changePic = PIC.BACKGROUND
        self.changePersonPic()
    }
    @IBAction func changePic(sender: AnyObject) {
        changePic = PIC.PERSON
        self.changePersonPic()
    }
    func pickerOK(name:NSString){
        var userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(name, forKey: "userPlace")
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    func changePersonPic(){
        var picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        var userDefault = NSUserDefaults.standardUserDefaults()
        if(changePic == PIC.PERSON){
            userDefault.setObject(NSKeyedArchiver.archivedDataWithRootObject(image), forKey: "userImage")
            userImage.imageView?.image = image
        }else{
            userDefault.setObject(NSKeyedArchiver.archivedDataWithRootObject(image), forKey: "userBG")
            userBg.imageView?.image = image
        }
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
        switch section{
        case 0:
            if(select == true){
                return 2
            }
            return 1
        case 1:
            return 2
        default:
            break
        }
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if(select == true && indexPath.section == 0 && indexPath.row == 1){
            return 102
        }
        return 46
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell()
        var cell1 = tableView.dequeueReusableCellWithIdentifier("PickerCell") as UserPickerViewCell
        //cell.backgroundColor = UIColor.clearColor()
        //cell.labelName.text = LEFT_LIST[indexPath.row]
        
        if(indexPath.section == 0){
            if(select == true){
                if(indexPath.row == 1){
                    cell1.delegate = self
                    if((NSUserDefaults.standardUserDefaults().valueForKey("userPlace")) != nil){
                        cell1.setSelect(NSUserDefaults.standardUserDefaults().valueForKey("userPlace") as NSString)
                    }
                    return cell1
                }
            }
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            if(indexPath.row == 0){
                var userDefaults = NSUserDefaults.standardUserDefaults()
                if((userDefaults.valueForKey("userPlace")) != nil){
                    cell.detailTextLabel?.text = userDefaults.valueForKey("userPlace") as NSString
                }else{
                    cell.detailTextLabel?.text = detailTitle[indexPath.row]
                }
            }else{
                cell.detailTextLabel?.text = detailTitle[indexPath.row]
            }
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
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                if(select == true){
                    select = false
                    tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
                }else{
                    select = true
                    tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            }
        }
        if(indexPath.section == 1){
            if(indexPath.row == 0){
                changePic = PIC.PERSON
                self.changePersonPic()
            }else{
                changePic = PIC.BACKGROUND
                self.changePersonPic()
            }
        }
        if(indexPath.section == 2){
            NSUserDefaults.standardUserDefaults().setObject("0", forKey: "login")
            //self.navigationController?.popViewControllerAnimated(true)
            delegate?.popUserViewController()
            self.dismissViewControllerAnimated(true, completion: nil)

        }
    }
}

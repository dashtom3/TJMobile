	//
//  LoginViewController.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/21.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var unLoginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 4
        unLoginBtn.layer.masksToBounds = true
        unLoginBtn.layer.cornerRadius = 4
        unLoginBtn.layer.borderWidth = 1
        unLoginBtn.layer.borderColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1,1,1,1])
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        if(NSUserDefaults.standardUserDefaults().valueForKey("login") != nil){
            if((NSUserDefaults.standardUserDefaults().valueForKey("login") as NSString).isEqualToString("1")){
                self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("master") as ViewController, animated: true)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showLoginView(sender: AnyObject) {
//        self.presentViewController(self.storyboard?.instantiateViewControllerWithIdentifier("user") as UserViewController, animated: true, completion: nil)
        
    }
    @IBAction func showMasterView(sender: AnyObject) {
        self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("master") as ViewController, animated: true)
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
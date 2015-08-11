//
//  AdvertisementViewController.swift
//  TJMobile
//
//  Created by 田程元 on 15/8/9.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit

class AdvertisementViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
        
        scrollView.delegate = self
        scrollView.bounces = false
        var imageNames = ["ad_1","ad_2","ad_3"]
        var width = UIScreen.mainScreen().bounds.width
        var height = UIScreen.mainScreen().bounds.height
        scrollView.contentSize = CGSizeMake(width*3, height)
        for(var i=0;i<imageNames.count;i++){
            var imageView = UIImageView(image: UIImage(named: imageNames[i]))
            imageView.frame = CGRectMake(width*CGFloat(i), 0, width, height)
            scrollView.addSubview(imageView);
        }
        
        enterBtn.layer.cornerRadius = 4
        enterBtn.layer.borderWidth = 1
        enterBtn.layer.borderColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1,1,1,1])
        enterBtn.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func enterApp(sender: AnyObject) {
        var navController = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("first_2") as! LoginViewController)
        navController.setNavigationBarHidden(true, animated: false)
        self.navigationController?.presentViewController(navController, animated: true, completion: nil)
    }
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageControl.currentPage =  Int(floor((scrollView.contentOffset.x - self.view.frame.size.width/2)/self.view.frame.size.width))+1;
        if(pageControl.currentPage == 2){
            buttonAnimation(false)
        }else{
            buttonAnimation(true)
        }
    }
    
    func buttonAnimation(state:Bool){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        UIView.setAnimationDelegate(self)
        enterBtn.hidden = state
        UIView.commitAnimations()
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

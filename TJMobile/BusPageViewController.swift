//
//  BusPageViewController.swift
//  TJMobile
//
//  Created by 田程元 on 15/3/30.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit

class BusPageViewController: UIViewController,UIScrollViewDelegate{
    @IBOutlet weak var pageControl: UIPageControl!
    var views:[PageView] = [PageView(),PageView(),PageView()]
    let names = ["page_1","page_2","page_3"]
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(self.view.frame.width*CGFloat(names.count), self.view.frame.height)
        for(var i = 0;i<names.count;i++){
            views[i] = (NSBundle.mainBundle().loadNibNamed("PageView", owner: nil, options: nil)[0]) as PageView
            views[i].frame = CGRectMake(self.view.frame.width*CGFloat(i), 0, self.view.frame.width, self.view.frame.height)
            views[i].imageView.image = UIImage(named: names[i])
            scrollView.addSubview(views[i])
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backBusMainViewController(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var index:Int = (Int)(fabs(scrollView.contentOffset.x)/self.view.frame.size.width)
        pageControl.currentPage = index
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

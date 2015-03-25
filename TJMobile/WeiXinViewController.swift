//
//  WeiXinViewController.swift
//  TJMobile
//
//  Created by 田程元 on 15/3/25.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit

class WeiXinViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setStyle(num:Int){
        switch num{
        //移动图书馆
        case 1:
            imageView.image = UIImage(named:"master_wx_2")
            label.text = NSString(format: "%@微信号:tongjilib", cards[num].labelName)
            break
        //校友会
        case 2:
            imageView.image = UIImage(named:"master_wx_3")
            label.text = NSString(format: "%@微信号:TONGJI-xyh", cards[num].labelName)
            break
        //青春同济
        case 5:
            imageView.image = UIImage(named:"master_wx_6")
            label.text = NSString(format: "%@微信号:qctjwx", cards[num].labelName)
            break
        default:
            break
        }
        titleLabel.text = cards[num].labelName
    }

    @IBAction func backView(sender: AnyObject) {
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

}

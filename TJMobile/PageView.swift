//
//  PageView.swift
//  TJMobile
//
//  Created by 田程元 on 15/3/30.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit
protocol PageViewDelegate:NSObjectProtocol{
    func backBusMainViewController()
}
class PageView: UIView {
    var delegate:PageViewDelegate?
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func backView(sender: AnyObject) {
        delegate?.backBusMainViewController()
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

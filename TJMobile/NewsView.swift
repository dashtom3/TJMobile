//
//  NewsView.swift
//  TJMobile
//
//  Created by 田程元 on 15/3/16.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit
protocol NewsViewDelegate:NSObjectProtocol{
    func showLeftView()
}
class NewsView: UIView {
    var delegate: NewsViewDelegate?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func showLeftView(sender: AnyObject) {
        delegate?.showLeftView()
    }

}

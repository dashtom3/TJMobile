//
//  PageView.swift
//  TJMobile
//
//  Created by 田程元 on 15/3/30.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit

class PageView: UIView {
    var imageView: UIImageView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView=UIImageView(frame: self.bounds)
        imageView.contentMode = UIViewContentMode.ScaleToFill
        self.addSubview(imageView)
        self.imageView.clipsToBounds = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.layoutIfNeeded()
    }
    
}

//
//  BusTimeCell.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/23.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class BusTimeCell: UITableViewCell {

    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var labelWay: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setStyle(time:NSString,way:NSString){
        labelTime.text = time
        labelWay.text = way
        if(way == "预约已满"){
            alphaView.alpha = 0.7
        }else{
            alphaView.alpha = 0
        }
    }
}

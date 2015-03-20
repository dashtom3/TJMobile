//
//  LeftViewTableCell.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/18.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class LeftViewTableCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        var view:UIView = UIView()
        view.backgroundColor = UIColor(red: 48/255, green: 51/255, blue: 73/255, alpha: 1.0)
        self.selectedBackgroundView = view
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

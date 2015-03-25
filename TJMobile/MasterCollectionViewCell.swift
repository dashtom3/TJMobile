//
//  MasterCollectionViewCell.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/18.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class MasterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageName: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setStyle(num:Int){
        switch cards[num].visable{
        case 0:
            self.alpha = 0.5
            break;
        case 1:
            self.alpha = 1.0
            break
        case 2:
            self.alpha = 0.5
            break
        default:
            break;
        }
        labelName.text = cards[num].labelName
        imageName.image = UIImage(named: cards[num].picName)
    }
}

//
//  BusTicketCell.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/22.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class BusTicketCell: UITableViewCell {

    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelBusFrom: UILabel!
    @IBOutlet weak var labelBusTo: UILabel!
    @IBOutlet weak var labelDAO: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setStyle(num:Int){
        if(num == -1){
            self.backgroundColor = UIColor(red: 255/255, green: 144/255, blue: 0/255, alpha: 1)
            var dateConverter = DateConverter()
            var tomorrowDate = NSDate(timeIntervalSinceNow: NSTimeInterval(86400))
            var dayString = dateConverter.getyyyyFromDate(tomorrowDate)+"年"+dateConverter.getMMFromDate(tomorrowDate)+"月"+dateConverter.getddFromDate(tomorrowDate)+"日 "+dateConverter.getDayFromDate(tomorrowDate)
            self.labelTime.text = dayString
            self.labelBusTo.text = SCHOOL[selectNum[0]]
            self.labelBusFrom.text = SCHOOL[selectNum[1]]
        }else if(TICKET.num==0){
            self.backgroundColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
            self.labelTime.text = ""
            self.labelDAO.text = ""
            self.labelBusTo.text = ""
            self.labelBusFrom.text = "暂无车票信息"
        }else{
            self.backgroundColor = UIColor(red: 255/255, green: 144/255, blue: 0/255, alpha: 1)
            self.labelTime.text = TICKET.tickets[num].time
            self.labelBusTo.text = TICKET.tickets[num].busTo
            self.labelDAO.text = "到"
            self.labelBusFrom.text = TICKET.tickets[num].busFrom
        }
    }
}

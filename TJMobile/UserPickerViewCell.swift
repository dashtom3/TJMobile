//
//  UserPickerViewCell.swift
//  TJMobile
//
//  Created by 田程元 on 15/3/27.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit
protocol PickerViewDelegate:NSObjectProtocol{
    func pickerOK(name:NSString)

}
class UserPickerViewCell: UITableViewCell,UIPickerViewDataSource,UIPickerViewDelegate {
    let names = ["四平路校区","嘉定校区","沪西校区"]
    var delegate:PickerViewDelegate?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
    }
    func setSelect(name:NSString){
        for(var i=0;i<names.count;i++){
            if(name.isEqualToString(names[i])){
                pickerView.selectRow(i, inComponent: 0, animated: true)
            }
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return names[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerOK(names[row])
    }
}

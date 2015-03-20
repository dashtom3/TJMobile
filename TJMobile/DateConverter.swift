//
//  DateConverter.swift
//  TJMobile
//
//  Created by 田程元 on 15/2/26.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit

class DateConverter: NSObject {
    func getDateFromNSString(timeString:NSString)->NSDate{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.dateFromString(timeString)!
    }
    func getHHFromDate(timeDate:NSDate)->NSString{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.stringFromDate(timeDate)
    }
    func getMMFromDate(timeDate:NSDate)->NSString{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.stringFromDate(timeDate)
    }
    func getddFromDate(timeDate:NSDate)->NSString{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.stringFromDate(timeDate)
    }
    func getHHmmFromDate(timeDate:NSDate)->NSString{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.stringFromDate(timeDate)
    }
    func getyyyyFromDate(timeDate:NSDate)->NSString{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.stringFromDate(timeDate)
    }
    func getmmFromDate(timeDate:NSDate)->NSString{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm"
        return dateFormatter.stringFromDate(timeDate)
    }
    func getDayFromDate(timeDate:NSDate)-> NSString{
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var comps = NSDateComponents()
        var a:Int = calendar!.components(NSCalendarUnit.CalendarUnitWeekday, fromDate: timeDate).weekday
        switch a{
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            break
        }
        return "错误"
    }
}

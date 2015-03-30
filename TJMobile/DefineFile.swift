//
//  DefineFile.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/18.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit
// visable 0 不显示 1 可用 2 不可用
struct collectionViewData {
    let labelName:NSString
    let picName:NSString
    var visable:Int
    init(labelName:NSString,picName:NSString,visable:Int){
        self.labelName = labelName
        self.picName = picName
        self.visable = visable
    }
}
struct viewFrame{
    let firstFrame:CGRect
    let secondFrame:CGRect
    init(firstFrame:CGRect,secondFrame:CGRect){
        self.firstFrame = firstFrame
        self.secondFrame = secondFrame
    }
}
struct ticket{
    var num:Int = 0
    var tickets:[ticketInfo] = []
    var todayNum:Int = 0
    var todayNumInTickets:Int = 0
}
struct ticketInfo{
    var time:NSString
    var busFrom:NSString
    var busTo:NSString
    var bus_id:NSString
    var ticket_id:NSString
    init(time:NSString,busFrom:NSString,busTo:NSString,bus_id:NSString,ticket_id:NSString){
        self.time = time
        self.busFrom = busFrom
        self.busTo = busTo
        self.bus_id = bus_id
        self.ticket_id = ticket_id
    }
}
struct route{
    var route_id:Int
    var start:NSString
    var end:NSString
    var weekend:Int
}
var GREEN_CARD = collectionViewData(labelName: "校车预约", picName: "master_1",visable:1)
var BLUE_CARD = collectionViewData(labelName: "移动图书馆", picName: "master_2",visable:1)
var GRAY_CARD = collectionViewData(labelName: "校友会", picName: "master_3",visable:1)
var PINK_CARD = collectionViewData(labelName: "教师办公系统", picName: "master_4",visable:1)
var YELLOW_CARD = collectionViewData(labelName: "同济官方", picName: "master_5",visable:1)
var DARKGREEN_CARD = collectionViewData(labelName: "青春同济", picName: "master_6",visable:1)
var RED_CARD = collectionViewData(labelName: "POI", picName: "master_7",visable:2)
var BROWN_CARD = collectionViewData(labelName: "办事指南", picName: "master_8",visable:2)
var DARKBLUE_CARD = collectionViewData(labelName: "校园通讯录", picName: "master_9",visable:2)
var PINKRED_CARD = collectionViewData(labelName: "个人信息中心", picName: "master_10",visable:2)
var cards = [GREEN_CARD,BLUE_CARD,GRAY_CARD,PINK_CARD,YELLOW_CARD,DARKGREEN_CARD,RED_CARD,BROWN_CARD,DARKBLUE_CARD,PINKRED_CARD]

let LEFT_LIST = ["同济应用","同济资讯"]
var TICKET = ticket(num: 0, tickets: [], todayNum:0, todayNumInTickets:0)
let SCHOOL = ["四平校区","嘉定校区","同济北苑","沪西校区","曹杨八村"]
var selectNum:[Int] = [0,0,0]
//var time:[timeANDline] = []
//用户 车票信息
var routeLine = NSArray()
var httpState = 0//0 登陆 1 查询 2 抢票 3 退票 
var userInfo = NSDictionary()

var routeList = NSArray()
var routeMatrix = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]

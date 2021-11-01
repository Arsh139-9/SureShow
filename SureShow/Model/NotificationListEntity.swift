//
//  NotificationListEntity.swift
//  SureShow
//
//  Created by Apple on 22/10/21.
//

import Foundation
//{
//    "status": 200,
//    "message": "Notification data find successfully",
//    "data": [
//    {
//    "id": 1,
//    "notify_type": 1,
//    "notify_title": "Test Title",
//    "notify_message": "F D1 N8",
//    "user_id": 14,
//    "add_user_id": 1,
//    "read_by": "",
//    "creation_date": "",
//    "status": 1,
//    "image": "https://comeonnow.io/come_on_now/user_image/1634119029_Screenshotfrom2021-10-0715-31-18.png"
//    }
//    ]
//}

struct GetNotificationListData<T>{
    
    var status: Int
    var message: String
    var notificationListArray:[NotificationListData<T>]
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataArr = dict["data"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = alertMessage
        var hArray = [NotificationListData<T>]()
        for obj in dataArr{
            let childListObj = NotificationListData(dataDict:obj)!
            hArray.append(childListObj)
        }
        self.notificationListArray = hArray
    }
}

struct NotificationListData<T>{
    var id:Int
    var notify_type:String
    var notify_title:String
    var notify_message:String
    var user_id:Int
    var add_user_id:Int
    var read_by:String
    var creation_date:String
    var image:String
    var appoint_start_time:String
    var appoint_end_time:String
    var status:Int
    
    init?(dataDict:[String:T]) {
        
        let id = dataDict["id"] as? Int ?? 0
        let notify_type = dataDict["notify_type"] as? String ?? ""
        let notify_title = dataDict["notify_title"] as? String ?? ""
        let notify_message = dataDict["notify_message"] as? String ?? ""
        let read_by = dataDict["read_by"] as? String ?? ""
        let creation_date = dataDict["creation_date"] as? String ?? ""
        let image = dataDict["image"] as? String ?? ""
        let appoint_start_time = dataDict["appoint_start_time"] as? String ?? ""
        let appoint_end_time = dataDict["appoint_end_time"] as? String ?? ""
        let add_user_id = dataDict["add_user_id"] as? Int ?? 0
        let user_id = dataDict["user_id"] as? Int ?? 0

        let status = dataDict["status"] as? Int ?? 0
        
        self.id = id
        self.notify_type = notify_type
        self.notify_title = notify_title
        self.notify_message = notify_message
        self.read_by = read_by
        self.creation_date = creation_date
        self.image = image
        self.appoint_start_time = appoint_start_time
        self.appoint_end_time = appoint_end_time
        self.add_user_id = add_user_id
        self.user_id = user_id
        self.status = status

        
    }
    
}

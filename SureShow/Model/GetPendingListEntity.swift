//
//  GetPendingListEntity.swift
//  SureShow
//
//  Created by Apple on 20/10/21.
//

import Foundation

struct GetPendingAppointmentData<T>{
    
    
    
    var status: Int
    var message: String
    var getPendingAppointmentListArray:[GetPendingAppointmentListData<T>]
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataArr = dict["data"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = alertMessage
        var hArray = [GetPendingAppointmentListData<T>]()
        for obj in dataArr{
            let childListObj = GetPendingAppointmentListData(dataDict:obj)!
            hArray.append(childListObj)
        }
        self.getPendingAppointmentListArray = hArray
    }
}

struct GetPendingAppointmentListData<T>{
    var id:Int
    var user_id:String
    var name:String
    var image:String
    var type:String
    var dob:String
    var gender:Int
    var loginuser_name:String
    var relationship:Int
    var age:Int
    var appoint_date:String
    var appoint_start_time:String
    var appoint_end_time:String

    
    init?(dataDict:[String:T]) {
        
        let id = dataDict["id"] as? Int ?? 0
        let user_id = dataDict["user_id"] as? String ?? ""
        let name = dataDict["name"] as? String ?? ""
        let image = dataDict["image"] as? String ?? ""
        let type = dataDict["type"] as? String ?? ""
        let dob = dataDict["dob"] as? String ?? ""
        let gender = dataDict["gender"] as? Int ?? 0
        let loginuser_name = dataDict["loginuser_name"] as? String ?? ""
        let relationship = dataDict["relationship"] as? Int ?? 0
        let age = dataDict["age"] as? Int ?? 0
        let appoint_date = dataDict["appoint_date"] as? String ?? ""
        let appoint_start_time = dataDict["appoint_start_time"] as? String ?? ""
        let appoint_end_time = dataDict["appoint_end_time"] as? String ?? ""

        
        
        self.id = id
        self.user_id = user_id
        self.name = name
        self.image = image
        self.type = type
        self.dob = dob
        self.gender = gender
        self.loginuser_name = loginuser_name
        self.relationship = relationship
        self.age = age
        self.appoint_date = appoint_date
        self.appoint_start_time = appoint_start_time
        self.appoint_end_time = appoint_end_time

    }
    
}



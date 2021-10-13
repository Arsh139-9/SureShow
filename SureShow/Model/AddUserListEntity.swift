//
//  AddUserListEntity.swift
//  SureShow
//
//  Created by Apple on 12/10/21.
//

import Foundation

struct AddUserListData<T>{
    
    
    //{
    //    "status": 1,
    //    "message": "New password has been sent to the entered email, please check your email."
    //}
    var status: Int
    var message: String
    var id:String
    var user_id:String
    var name:String
    var image:String
    var type:String
    var dob:String
    var gender:String
    var created_at:String
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataDict = dict["data"] as? [String:T] ?? [:]
        let id = dataDict["id"] as? String ?? ""
        let user_id = dataDict["user_id"] as? String ?? ""
        let name = dataDict["name"] as? String ?? ""
        let image = dataDict["image"] as? String ?? ""
        let type = dataDict["type"] as? String ?? ""
        let dob = dataDict["dob"] as? String ?? ""
        let gender = dataDict["gender"] as? String ?? ""
        let created_at = dataDict["created_at"] as? String ?? ""
        
        self.status = status
        self.message = alertMessage
        self.id = id
        self.user_id = user_id
        self.name = name
        self.image = image
        self.type = type
        self.dob = dob
        self.gender = gender
        self.created_at = created_at
    }
}

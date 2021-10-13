//
//  HomeUserListEntity.swift
//  SureShow
//
//  Created by Apple on 12/10/21.
//

import Foundation
//{
//    "status": 200,
//    "message": "User Details find Successfully!",
//    "data": [
//    {
//    "id": 1,
//    "user_id": 11,
//    "name": "komal",
//    "image": "https://comeonnow.io/come_on_now/user_image/1634016629_undefined(2).jpg",
//    "type": 1,
//    "dob": "21-2-2021",
//    "gender": 1,
//    "created_at": "2021-10-11 07:09:43"
//    },
//    {
//    "id": 2,
//    "user_id": 11,
//    "name": "sheenu",
//    "image": "https://comeonnow.io/come_on_now/user_image/",
//    "type": 1,
//    "dob": "21-2-2021",
//    "gender": 1,
//    "created_at": "2021-10-11 07:11:06"
//    },
//    {
//    "id": 3,
//    "user_id": 11,
//    "name": "sheenu sharma",
//    "image": "https://comeonnow.io/come_on_now/user_image/",
//    "type": 1,
//    "dob": "17-10-1997",
//    "gender": 1,
//    "created_at": "2021-10-11 07:12:12"
//    }
//    ]
//}

struct GetHomeUserListData<T>{
    
    
   
    var status: Int
    var message: String
    var homeUserListArray:[UserListData<T>]
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataArr = dict["data"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = alertMessage
        var hArray = [UserListData<T>]()
        for obj in dataArr{
            let childListObj = UserListData(dataDict:obj)!
            hArray.append(childListObj)
        }
        self.homeUserListArray = hArray
    }
}

struct UserListData<T>{
    var id:Int
    var user_id:String
    var name:String
    var image:String
    var type:String
    var dob:String
    var gender:Int
    var loginusername:String
    var created_at:String

    init?(dataDict:[String:T]) {
        
        let id = dataDict["id"] as? Int ?? 0
        let user_id = dataDict["user_id"] as? String ?? ""
        let name = dataDict["name"] as? String ?? ""
        let image = dataDict["image"] as? String ?? ""
        let type = dataDict["type"] as? String ?? ""
        let dob = dataDict["dob"] as? String ?? ""
        let gender = dataDict["gender"] as? Int ?? 0
        let loginusername = dataDict["loginusername"] as? String ?? ""
        let created_at = dataDict["created_at"] as? String ?? ""

        
        
        
        self.id = id
        self.user_id = user_id
        self.name = name
        self.image = image
        self.type = type
        self.dob = dob
        self.gender = gender
        self.loginusername = loginusername
        self.created_at = created_at

    }
    
}


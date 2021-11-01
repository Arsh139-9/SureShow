//
//  GetPatientListEntity.swift
//  SureShow
//
//  Created by Apple on 19/10/21.
//

import Foundation
//{
//    "status": 200,
//    "message": "User deleted successfully",
//    "data": [
//    {
//    "id": 12,
//    "name": "Ar",
//    "is_self": 0
//    },
//    {
//    "id": 13,
//    "name": "Art",
//    "is_self": 0
//    }
//    ]
//}



struct GetPatientData<T>{
    
    var status: Int
    var message: String
    var patientListArray:[PatientListData<T>]
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataArr = dict["data"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = alertMessage
        var hArray = [PatientListData<T>]()
        for obj in dataArr{
            let childListObj = PatientListData(dataDict:obj)!
            hArray.append(childListObj)
        }
        self.patientListArray = hArray
    }
}

struct PatientListData<T>{
    var id:Int
    var name:String
    var first_name:String
    var last_name:String

    var is_self:Int
    
    init?(dataDict:[String:T]) {
        
        let id = dataDict["id"] as? Int ?? 0
        let name = dataDict["name"] as? String ?? ""
        let first_name = dataDict["first_name"] as? String ?? ""
        let last_name = dataDict["last_name"] as? String ?? ""

        let is_self = dataDict["is_self"] as? Int ?? 0
        
        self.id = id
        self.name = name
        self.first_name = first_name
        self.last_name = last_name

        self.is_self = is_self
        
    }
    
}

//
//  GetHospitalEntity.swift
//  SureShow
//
//  Created by Apple on 14/10/21.
//

import Foundation
//{
//    "status": 200,
//    "message": "Data find successfully",
//    "data": [
//    {
//    "clinic_id": 1,
//    "clinic_name": "Clinic A",
//    "created_on": "2021-10-13 12:03:21",
//    "status": 1
//    },
//    {
//    "clinic_id": 2,
//    "clinic_name": "Clinic B",
//    "created_on": "2021-10-13 12:03:21",
//    "status": 1
//    }
//    ]
//}
struct GetHospitalData<T>{
    
    var status: Int
    var message: String
    var hospitalListArray:[HospitalListData<T>]
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataArr = dict["data"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = alertMessage
        var hArray = [HospitalListData<T>]()
        for obj in dataArr{
            let childListObj = HospitalListData(dataDict:obj)!
            hArray.append(childListObj)
        }
        self.hospitalListArray = hArray
    }
}

struct HospitalListData<T>{
    var clinic_id:Int
    var clinic_name:String
    var created_on:String
    var status: Int

    init?(dataDict:[String:T]) {
        
        let clinic_id = dataDict["clinic_id"] as? Int ?? 0
        let clinic_name = dataDict["clinic_name"] as? String ?? ""
        let created_on = dataDict["created_on"] as? String ?? ""
        let status = dataDict["status"] as? Int ?? 0

        self.clinic_id = clinic_id
        self.clinic_name = clinic_name
        self.created_on = created_on
        self.status = status

    }
    
}



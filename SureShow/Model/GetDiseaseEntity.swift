//
//  GetDiseaseEntity.swift
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
//    "id": 1,
//    "disease_name": "Diabetes",
//    "creation_date": "2021-10-14 07:34:04",
//    "status": 1
//    },
//    {
//    "id": 2,
//    "disease_name": "Fever",
//    "creation_date": "2021-10-14 07:34:04",
//    "status": 1
//    }
//    ]
//}
struct GetDiseaseData<T>{
    
    var status: Int
    var message: String
    var diseaseListArray:[DiseaseListData<T>]
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataArr = dict["data"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = alertMessage
        var hArray = [DiseaseListData<T>]()
        for obj in dataArr{
            let childListObj = DiseaseListData(dataDict:obj)!
            hArray.append(childListObj)
        }
        self.diseaseListArray = hArray
    }
}

struct DiseaseListData<T>{
    var id:Int
    var disease_name:String
    var creation_date:String
    
    init?(dataDict:[String:T]) {
        
        let id = dataDict["id"] as? Int ?? 0
        let disease_name = dataDict["disease_name"] as? String ?? ""
        let creation_date = dataDict["creation_date"] as? String ?? ""
        
        self.id = id
        self.disease_name = disease_name
        self.creation_date = creation_date
        
    }
    
}

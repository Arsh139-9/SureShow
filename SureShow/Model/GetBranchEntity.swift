//
//  GetBranchEntity.swift
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
//    "id": 3,
//    "clinic_id": 1,
//    "branch_name": "Branch A",
//    "status": 1,
//    "created_at": "2021-10-13 12:05:07"
//    },
//    {
//    "id": 4,
//    "clinic_id": 1,
//    "branch_name": "Branch B",
//    "status": 1,
//    "created_at": "2021-10-13 12:05:07"
//    }
//    ]
//}
struct GetBranchData<T>{
    
    var status: Int
    var message: String
    var branchListArray:[BranchListData<T>]
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataArr = dict["data"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = alertMessage
        var hArray = [BranchListData<T>]()
        for obj in dataArr{
            let childListObj = BranchListData(dataDict:obj)!
            hArray.append(childListObj)
        }
        self.branchListArray = hArray
    }
}

struct BranchListData<T>{
    var id:Int
    var clinic_id:Int
    var branch_name:String
    var created_at:String
    var status: Int
    
    init?(dataDict:[String:T]) {
        
        let id = dataDict["id"] as? Int ?? 0
        let clinic_id = dataDict["clinic_id"] as? Int ?? 0
        let branch_name = dataDict["branch_name"] as? String ?? ""
        let created_at = dataDict["created_at"] as? String ?? ""
        let status = dataDict["status"] as? Int ?? 0
        
        self.id = id
        self.clinic_id = clinic_id
        self.branch_name = branch_name
        self.created_at = created_at
        self.status = status
        
    }
    
}

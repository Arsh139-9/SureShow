//
//  GetProviderEntity.swift
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
//    "id": 4,
//    "name": "komal arya"
//    },
//    {
//    "id": 5,
//    "name": "komal arya"
//    }
//    ]
//}

struct GetProviderData<T>{
    
    var status: Int
    var message: String
    var providerListArray:[ProviderListData<T>]
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataArr = dict["data"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = alertMessage
        var hArray = [ProviderListData<T>]()
        for obj in dataArr{
            let childListObj = ProviderListData(dataDict:obj)!
            hArray.append(childListObj)
        }
        self.providerListArray = hArray
    }
}

struct ProviderListData<T>{
    var id:Int
    var name:String
    
    init?(dataDict:[String:T]) {
        let id = dataDict["id"] as? Int ?? 0
        let name = dataDict["name"] as? String ?? ""
        
        self.id = id
        self.name = name
        
    }
    
}

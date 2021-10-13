//
//  GetRelationshipEntity.swift
//  SureShow
//
//  Created by Apple on 13/10/21.
//

import Foundation
//{
//    "status": 200,
//    "message": "Relationship data find successfully",
//    "data": [
//    {
//    "id": 1,
//    "relationship_name": "Wife",
//    "created_at": "2021-10-13 10:27:33"
//    },
//    {
//    "id": 2,
//    "relationship_name": "Brother",
//    "created_at": "2021-10-13 10:27:33"
//    },
//    {
//    "id": 3,
//    "relationship_name": "Child",
//    "created_at": "2021-10-13 10:28:03"
//    },
//    {
//    "id": 4,
//    "relationship_name": "Father",
//    "created_at": "2021-10-13 10:28:03"
//    }
//    ]
//}
struct GetRelationshipData<T>{
  
    var status: Int
    var message: String
    var relationshipListArray:[RelationshipListData<T>]
    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataArr = dict["data"] as? [[String:T]] ?? [[:]]
        
        self.status = status
        self.message = alertMessage
        var hArray = [RelationshipListData<T>]()
        for obj in dataArr{
            let childListObj = RelationshipListData(dataDict:obj)!
            hArray.append(childListObj)
        }
        self.relationshipListArray = hArray
    }
}

struct RelationshipListData<T>{
    var id:Int
    var relationship_name:String
    var created_at:String
    
    init?(dataDict:[String:T]) {
        
        let id = dataDict["id"] as? Int ?? 0
        let relationship_name = dataDict["relationship_name"] as? String ?? ""
        let created_at = dataDict["created_at"] as? String ?? ""
 
        self.id = id
        self.relationship_name = relationship_name
        self.created_at = created_at
        
    }
    
}


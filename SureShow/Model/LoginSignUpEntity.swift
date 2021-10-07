//
//  LoginSignUpEntity.swift
//  ICMA
//
//  Created by Apple on 06/10/21.
//


import Foundation
//{
//    "status": 200,
//    "message": "successfully login",
//    "access_token": "C6bVW40cViBYvlfwNuXF17gZo6BVPsMb"
//}



struct LoginSignUpData<T>{
    
    var status:Int
    var alertMessage:String
    var access_token:String
    

    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  access_token = dict["access_token"] as? String ?? ""
        
      
        self.status = status
        self.alertMessage = alertMessage
        self.access_token = access_token
        
    }
}


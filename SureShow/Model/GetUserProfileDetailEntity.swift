//
//  GetUserProfileDetailEntity.swift
//  comeonnow
//
//  Created by Arshdeep Singh on 24/06/21.
//

import Foundation


//{
//    data =     {
//        cellno = "<null>";
//        email = "dharmaniz.arshdeepsingh@gmail.com";
//        "first_name" = Arshdeep;
//        image = "https://comeonnow.io/come_on_now/user_image/";
//        "last_name" = Singh;
//    };
//    message = "";
//    status = 200;
//}


struct GetUserProfileData<T>{
  
  
    
    var status: Int
    var message: String
    var cellno: String
    var email: String
    var image: String
    var first_name: String
    var last_name: String
    var country_code: String



    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        let  dataDict = dict["data"] as? [String:T] ?? [:]
        let cellno = dataDict["cellno"] as? String ?? ""
        let email = dataDict["email"] as? String ?? ""
        let image = dataDict["image"] as? String ?? ""
        let first_name = dataDict["first_name"] as? String ?? ""
        let last_name = dataDict["last_name"] as? String ?? ""
        let country_code = dataDict["countrycode"] as? String ?? ""

        self.status = status
        self.message = alertMessage
        self.cellno = cellno
        self.email = email
        self.image = image
        self.first_name = first_name
        self.last_name = last_name
        self.country_code = country_code


    }
}

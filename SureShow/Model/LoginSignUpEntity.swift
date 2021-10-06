//
//  LoginSignUpEntity.swift
//  ICMA
//
//  Created by Apple on 06/10/21.
//


import Foundation
//{
//    "status": 200,
//    "message": "You are now a member!",
//    "data": {
//        "id": 5,
//        "stripe_cus_id": null,
//        "username": "dharmaniz.ar1@gmail.com",
//        "name": "komal arya",
//        "usertype": null,
//        "image": null,
//        "password": "$2y$13$uEL0jFavNMi9KqUYYyq9TOuqIkopJkODL.Cgmi4oixOJ5OZe7fF1q",
//        "cellno": null,
//        "dob": null,
//        "age": null,
//        "goal": null,
//        "user_location": null,
//        "payment_details": null,
//        "allow_without_payment": 0,
//        "trial_period": 0,
//        "plan_type": null,
//        "device_token": null,
//        "device_type": null,
//        "push_status": null,
//        "mail_status": 1,
//        "sms_status": 1,
//        "supervisor": null,
//        "company_user": null,
//        "company_name": null,
//        "status": 1,
//        "auth_key": "cWufJaiax_eaURsTJzMWNFVh1xk0sMAd",
//        "access_token": null,
//        "verification_token": null,
//        "password_reset_token": null,
//        "expire_at": null,
//        "lastvisit": null,
//        "superuser": null,
//        "created_at": "2021-10-06 11:53:17",
//        "updated_at": null,
//        "referral_code": null,
//        "subscription_status": 0,
//        "assigned_group": 0,
//        "current_meal": null,
//        "checkin_status": 1,
//        "last_checkin_date": null,
//        "custom_programming": 0,
//        "manual_training": null
//    }
//}



struct LoginSignUpData<T>{
    
    var status:Int
    var alertMessage:String
    var id:String
    var username:String
    var name:String
    var password:String
    var allow_without_payment:String
    var trial_period:String
    var mail_status:String
    var sms_status:String
    var auth_key:String
    var created_at:String
    var subscription_status:String
    var assigned_group:String
    var checkin_status:String
    var custom_programming:String

    
    
    init?(dict:[String:T]) {
        let status  = dict["status"] as? Int ?? 0
        let alertMessage = dict["message"] as? String ?? ""
        
        let  dataDict = dict["data"] as? [String:T] ?? [:]
        
        
        let id = dataDict["id"] as? String ?? ""
        let username = dataDict["username"] as? String ?? ""
        let name = dataDict["name"] as? String ?? ""
        let password = dataDict["password"] as? String ?? ""
        let allow_without_payment = dataDict["allow_without_payment"] as? String ?? ""
        let trial_period = dataDict["trial_period"] as? String ?? ""
        let mail_status = dataDict["mail_status"] as? String ?? ""
        let sms_status = dataDict["sms_status"] as? String ?? ""
        let auth_key = dataDict["auth_key"] as? String ?? ""
        let created_at = dataDict["created_at"] as? String ?? ""
        let subscription_status = dataDict["subscription_status"] as? String ?? ""
        let assigned_group = dataDict["assigned_group"] as? String ?? ""
        let checkin_status = dataDict["checkin_status"] as? String ?? ""
        let custom_programming = dataDict["custom_programming"] as? String ?? ""
        
        self.status = status
        self.alertMessage = alertMessage
        self.id = id
        self.username = username
        self.name = name
        self.password = password
        self.allow_without_payment = allow_without_payment
        self.trial_period = trial_period
        self.mail_status = mail_status
        self.sms_status = sms_status
        self.auth_key = auth_key
        self.created_at = created_at
        self.subscription_status = subscription_status
        self.assigned_group = assigned_group
        self.checkin_status = checkin_status
        self.custom_programming = custom_programming
        
        
    }
}


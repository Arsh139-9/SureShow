//
//  AppMultipleApisModal.swift
//  SureShow
//
//  Created by Apple on 14/10/21.
//

import Foundation
import Alamofire

class ModalResponse{
    open func getRelationshipListApi(onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.getRelationshipList, params:nil, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in
            
            failure(error)
        }
        
    }
    open func getPatientListApi(onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.getPatientList, params:nil, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in
            
            failure(error)
        }
        
    }
    
    open func getHospitalListApi(onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.getClinicList, params:nil, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in
            
            failure(error)
        }
        
    }
    open func getBranchListApi(clinicId:Int,onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.getBranchList + "?clinic_id=\(clinicId)", params:nil, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in
            
            failure(error)
        }
        
    }
    open func getProviderListApi(clinicId:Int,branchId:Int,onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        //branch_id=3&clinic_id=1
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.getProviderList + "?branch_id=\(branchId)&clinic_id=\(clinicId)", params:nil, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in
            
            failure(error)
        }
        
    }
    open func getDiseaseListApi(onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.getDiseaseList, params:nil, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in
            
            failure(error)
        }
        
    }
    open func getCPQListApi(perPage:Int,page:Int,status:Int,onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.addGetQueueList +  "?status=\(status)&per-page=\(perPage)&page=\(page)", params:nil, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in
            
            failure(error)
        }
        
    }
    public func getAppointmentHistoryListApi(perPage:Int,page:Int,onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""

        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
       
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.getAppointmentHistory + "?per-page=\(perPage)&page=\(page)", params:nil, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in

            failure(error)
        }

    }
    open func pendingAppointmentAcceptRejectApi(params:[String : Any]?,onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        
        AFWrapperClass.requestPostWithMultiFormData(kBASEURL + WSMethods.acceptReject, params:params, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in
            
            failure(error)
        }
        
    }
    open func getNotificationListApi(perPage:Int,page:Int,onSuccess success: @escaping ([String:AnyObject]) -> Void, onFailure failure: @escaping (Error) -> Void) {
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.notificationList +  "?per-page=\(perPage)&page=\(page)", params:nil, headers:headers) { response in
            let result = response as AnyObject
            print(result)
            if let json = result as? [String:AnyObject] {
                success(json as [String:AnyObject])
            }
        } failure: { error in
            
            failure(error)
        }
        
    }
    
}


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
}




//import UIKit
//import Alamofire
//
//class Api: NSObject {
//
//
//    private static var api:Api!
//
//    private static var apiLinker:ApiLinker!
//    let header = ["Secret-Key": "AJT_Lbim_0f6bd8a808ea3e9996b3aee1900aa2e8"]
//
//    class func share() -> Api{
//        if api == nil {
//            api = Api()
//            apiLinker = ApiLinker()
//        }
//        return api
//    }
//
//
//
//
//
//}
//
//// Mark: - Auth Api
//extension Api {
//    // Mark: - Signup
//    func signupUser(url: String, params: [String: AnyObject], completion:@escaping (User? , String?)->Void) {
//
//        Loader.shared.show()
//        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
//            return params
//        }, onResponse: { (response) in
//            Loader.shared.hide()
//            if let resp = response{
//                let status = resp["status"] as? Bool ?? false
//                if !status{
//                    if  resp["data"] != nil{
//                        let responseData = resp["data"] as! Dictionary<String, Any>
//
//                        do {
//                            let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
//                            do {
//                                let jsonDecoder = JSONDecoder()
//                                let user = try jsonDecoder.decode(User.self, from: jsonData)
//
//                                 let jsonString = String(data: jsonData, encoding: .utf8)
//                                 UserDefaults.standard.set(jsonString, forKey: DefaultsKeys.CURRENT_USERID)
//
//                                completion(user ,"")
//
//                            } catch {
//                                print("Unexpected error: \(error).")
//                                completion(nil, "Data not able to decode")
//                            }
//
//                        } catch {
//                            print(error.localizedDescription)
//                            completion(nil, "Data not able to decode")
//                        }
//
//                          completion(nil , "")
//                    } else{
//                        completion(nil , "")
//                    }
//                }
//                else{
//                  let msg = resp["message"] ?? "Some error Occured"
//                    completion(nil , msg as? String)
//
//                }
//            }
//        }) { (error) in
//            completion(nil, "Some error occured.")
//            Loader.shared.hide()
//        }
//    }
//
//    // Mark: - Login
//    func logInUser(url: String, params: [String: AnyObject], completion:@escaping (User?, String?)->Void) {
//        Loader.shared.show()
//        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
//            return params
//        }, onResponse: { (response) in
//            Loader.shared.hide()
//            if let resp = response{
//
//                let status = resp["status"] as? Bool ?? false
//                if !status{
//                    if  resp["data"] != nil{
//                        let responseData = resp["data"] as! Dictionary<String, Any>
//                        UserDefaults.standard.set(responseData, forKey: DefaultsKeys.CURRENT_USERID)
//                        do {
//                            let jsonData = try JSONSerialization.data(withJSONObject: responseData , options: .prettyPrinted)
//                            do {
//                                let jsonDecoder = JSONDecoder()
//                                let user = try jsonDecoder.decode(User.self, from: jsonData)
//
//                                let jsonString = String(data: jsonData, encoding: .utf8)
//                                UserDefaults.standard.set(jsonString, forKey: DefaultsKeys.CURRENT_USERID)
//
//                                completion(user ,"")
//
//                            } catch {
//                                print("Unexpected error: \(error).")
//                                completion(nil, "Data not able to decode")
//                            }
//
//                        } catch {
//                            print(error.localizedDescription)
//                            completion(nil, "Data not able to decode")
//                        }
//
//                        completion(nil , "")
//                    } else{
//                        completion(nil , "")
//                    }
//                }
//                else{
//                    let msg = resp["message"] ?? "Some error Occured"
//                    completion(nil , msg as? String)
//                }
//            }
//        }) { (error) in
//            completion(nil, "Some error occured.")
//            Loader.shared.hide()        }
//    }
//
//    // Mark: - Reset Password
//
//    func resetPassword(url: String, params: [String: AnyObject], completion:@escaping (Bool,String)->Void) {
//
//        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
//            return params
//        }, onResponse: { (response) in
//            if let resp = response{
//                let status = resp["status"] as? Bool ?? false
//                let message = resp["message"] as? String ?? ""
//                if !status{
//                    if  resp["data"] != nil{
//                        completion(status,message)
//                    } else{
//                        completion(status, message)
//                    }
//                }
//                else{
//                    completion(status,"error")
//                }
//            }
//        }) { (error) in
//            completion(false,error ?? "")
//        }
//    }
//
//    // Mark: - Change password
//
//    func changePassword(url: String, params: [String: AnyObject], completion:@escaping (Bool)->Void) {
//        Loader.shared.show()
//        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
//            return params
//        }, onResponse: { (response) in
//            Loader.shared.hide()
//            if let resp = response{
//                let status = resp["status"] as? Bool ?? false
//                let message = resp["message"] as? String ?? ""
//                if !status{
//                    if  resp["data"] != nil{
//                        completion(status)
//                    } else{
//                        completion(status)
//                    }
//                }
//                else{
//                    completion(status)
//                }
//            }
//        }) { (error) in
//            completion(false)
//        }
//    }
//}
//
//// Mark: - Profile Api
//extension Api {
//    func uploadImage(url:String, parameters:Dictionary<String, String>,image:UIImage, imageName:String, completion: @escaping (_ result:Dictionary<String, Any>?, _ message:String) -> Void, uploadProgress:@escaping (_ progress:Double)->Void){
//        Loader.shared.show()
//        Alamofire.upload (
//            multipartFormData: { multipartFormData in
//                for (key, value) in parameters {
//
//                        print("\(key) = \(value)")
//                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
//                }
//                multipartFormData.append(image.jpegData(compressionQuality: 0.4) ?? Data(), withName: imageName, fileName: "image.png", mimeType:  "image/png")
//        },
//            to: url,
//            headers: header,
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload,_, _):
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                        uploadProgress(progress.fractionCompleted)
//                    })
//                    upload.responseJSON { (response) in
//                        Loader.shared.hide()
//
//                        if response.error != nil {
//
//
//                            return
//                        }
//
//                        response.result.ifSuccess {
//                            /// Success
//                            upload.uploadProgress { progress in
//
//                                print(progress.fractionCompleted)
//                            }
//                            if let dict: Dictionary<String, Any> = response.result.value as? Dictionary<String, Any> {
//
//                                let status = (dict["status"]) as? Int
//                                if status == 0 {
//                                    completion(dict, (dict["message"] as? String) ?? "")
//                                    return
//
//                                }else{
//
//                                }
//                            }
//                        }
//                        response.result.ifFailure {
//                            /// Failed
//                            if let error = response.result.error {
//                                print(error)
//
//
//                                return
//                            }
//                        }
//
//                    }
//                case .failure(_): break
//
//                }
//        }
//        )
//    }
//
//}
//
//
//// Mark: - Get Jobs
//
//
//extension Api {
//
//    func getJobs(url: String, params: [String: AnyObject], completion:@escaping (Bool, [Jobs]?)->Void) {
//        Loader.shared.show()
//        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
//            params
//        }, onResponse: { (response) in
//            Loader.shared.hide()
//            if let result = response {
//                guard let status = result["status"] as? Int, status == 0, let data = result["data"] as? [Dictionary<String, Any>] else {
//                    completion(false, nil)
//                    return
//                }
//
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: data , options: .prettyPrinted)
//                    do {
//                        let jsonDecoder = JSONDecoder()
//                        let dashboard = try jsonDecoder.decode([Jobs].self, from: jsonData)
//                        print(dashboard)
//                        completion(false, dashboard)
//
//                    } catch {
//                        print("Unexpected error: \(error).")
//                       completion(false, nil)
//                    }
//
//                } catch {
//                    print(error.localizedDescription)
//                    completion(false, nil)
//                }
//            }
//
//
//
//
//        }) { (error) in
//
//        }
////        Api.apiLinker.requestMethod(method: .post).setHeader(headers: header).execute(url: url, parameters: { () -> [String : AnyObject]? in
////            return params
////        }, onResponse: { (response) in
////            Loader.shared.hide()
////            if let resp = response{
////                let status = resp["status"] as? Bool ?? false
////                let message = resp["message"] as? String ?? ""
////
////
////            }
////        }) { (error) in
////            completion(false)
////        }
//    }
//}

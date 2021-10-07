//
//  ChangePasswordVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 20/09/21.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift
import Alamofire
class ChangePasswordVC : BaseVC, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var txtConfirmPswrd: SSPasswordTextField!
    @IBOutlet weak var confirmPswrdView: UIView!
    @IBOutlet weak var txtNewPswrd: SSPasswordTextField!
    @IBOutlet weak var newPswrdView: UIView!
    @IBOutlet weak var chngPswrdView: UIView!
    @IBOutlet weak var txtChngPswrd: SSPasswordTextField!
    
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    var textTitle: String?
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        title = textTitle
        
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        
        txtChngPswrd.delegate = self
        txtNewPswrd.delegate = self
        txtConfirmPswrd.delegate = self
    }
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtChngPswrd.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter password." , okButton: "Ok", controller: self) {
            }

            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtNewPswrd.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter new password." , okButton: "Ok", controller: self) {
            }
            return false
        }
        
//        if ValidationManager.shared.isValid(text: txtNewPswrd.text!, for: RegularExpressions.password8AS) == false {
//            showAlertMessage(title: kAppName.localized(), message: "Please enter valid new password. Password should contain at least 8 characters, with at least 1 letter and 1 special character." , okButton: "Ok", controller: self) {
//            }
//            return false
//        }
        
        if ValidationManager.shared.isEmpty(text: txtConfirmPswrd.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter confirm password." , okButton: "Ok", controller: self) {
            }
            return false
        }
        
//        if ValidationManager.shared.isValid(text: txtConfirmPswrd.text!, for: RegularExpressions.password8AS) == false {
//            showAlertMessage(title: kAppName.localized(), message: "Please enter valid confirm password. Password should contain at least 8 characters, with at least 1 letter and 1 special character." , okButton: "Ok", controller: self) {
//            }
//            return false
//        }
        
        if (txtChngPswrd.text == txtNewPswrd.text) {
            showAlertMessage(title: kAppName.localized(), message: "The old and new password must not be the same." , okButton: "Ok", controller: self) {
            }

            return false
        }
        
        if (txtNewPswrd.text != txtConfirmPswrd.text) {
            showAlertMessage(title: kAppName.localized(), message: "New passwords and confirm password not match.", okButton: "OK", controller: self)
                {
                
            }
            return false
        }
        
        return true
    }
    
    open func changePasswordApi(){
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""

        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        AFWrapperClass.requestPostWithMultiFormData(kBASEURL + WSMethods.changePassword, params: generatingParameters(), headers: headers) { response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            let message = response["message"] as? String ?? ""
            if let status = response["status"] as? Int {
                if status == 200{
                    showAlertMessage(title: kAppName.localized(), message: message , okButton: "OK", controller: self) {
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                else if status == 401{
                    removeAppDefaults(key:"AuthToken")
                    appDel.logOut()
                }
                else{
                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                }
            }
            
        } failure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
    }
    func generatingParameters() -> [String:AnyObject] {
        var parameters:[String:AnyObject] = [:]
        parameters["password"] = txtNewPswrd.text  as AnyObject
        parameters["old_password"] = txtChngPswrd.text  as AnyObject

//        parameters["device_type"] = "1"  as AnyObject
//        var deviceToken  = getSAppDefault(key: "DeviceToken") as? String ?? ""
//        if deviceToken == ""{
//            deviceToken = "123"
//        }
//        parameters["device_token"] = deviceToken  as AnyObject
        print(parameters)
        return parameters
    }
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnBack(_ sender: Any) {
        self.pop()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if validate() == false {
            return
        }
        else{
            changePasswordApi()
        }
    }
    
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if IQKeyboardManager.shared.canGoNext {
            IQKeyboardManager.shared.goNext()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case txtChngPswrd:
            chngPswrdView.borderColor =  SSColor.appButton
        case txtNewPswrd :
            newPswrdView.borderColor = SSColor.appButton
        case txtConfirmPswrd :
            confirmPswrdView.borderColor = SSColor.appButton
        default:break
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case txtChngPswrd:
            chngPswrdView.borderColor =  SSColor.appBlack
        case txtNewPswrd :
            newPswrdView.borderColor = SSColor.appBlack
        case txtConfirmPswrd :
            confirmPswrdView.borderColor = SSColor.appBlack
        default:break
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

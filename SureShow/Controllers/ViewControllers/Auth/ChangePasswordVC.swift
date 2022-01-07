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
    
    @IBOutlet weak var cPImgView: UIImageView!
    @IBOutlet weak var nextPasswordImgView: UIImageView!
    @IBOutlet weak var confirmPasswordImgView: UIImageView!
    @IBOutlet weak var confirmPswrdView: UIView!
    @IBOutlet weak var newPswrdView: UIView!
    @IBOutlet weak var chngPswrdView: UIView!
    @IBOutlet weak var txtOldPassword: SSPasswordTextField!
    @IBOutlet weak var txtNewPassword: SSPasswordTextField!
    @IBOutlet weak var txtConfirmPassword: SSPasswordTextField!
    
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
        
        txtOldPassword.delegate = self
        txtNewPassword.delegate = self
        txtConfirmPassword.delegate = self
    }
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtOldPassword.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter password." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtNewPassword.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter new password." , okButton: "Ok", controller: self) {
            }
            return false
        }
        
        //        if ValidationManager.shared.isValid(text: txtNewPswrd.text!, for: RegularExpressions.password8AS) == false {
        //            showAlertMessage(title: kAppName.localized(), message: "Please enter valid new password. Password should contain at least 8 characters, with at least 1 letter and 1 special character." , okButton: "Ok", controller: self) {
        //            }
        //            return false
        //        }
        
        if ValidationManager.shared.isEmpty(text: txtConfirmPassword.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter confirm password." , okButton: "Ok", controller: self) {
            }
            return false
        }
        
        //        if ValidationManager.shared.isValid(text: txtConfirmPswrd.text!, for: RegularExpressions.password8AS) == false {
        //            showAlertMessage(title: kAppName.localized(), message: "Please enter valid confirm password. Password should contain at least 8 characters, with at least 1 letter and 1 special character." , okButton: "Ok", controller: self) {
        //            }
        //            return false
        //        }
        
        if (txtOldPassword.text == txtNewPassword.text) {
            showAlertMessage(title: kAppName.localized(), message: "The old and new password must not be the same." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if (txtNewPassword.text != txtConfirmPassword.text) {
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
        parameters["password"] = txtNewPassword.text  as AnyObject
        parameters["old_password"] = txtOldPassword.text  as AnyObject
        parameters["usertype"] = "2"  as AnyObject
        print(parameters)
        return parameters
    }
    //------------------------------------------------------
    
    //MARK: Actions
 
    @IBAction func hideShowPasswordBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 0{
            sender.isSelected ? oldPasswordEncrypt() : oldPasswordDecrypt()
        }else if sender.tag == 1{
            sender.isSelected ? newPasswordEncrypt() : newPasswordDecrypt()
        }else if sender.tag == 2{
            sender.isSelected ? confirmPasswordEncrypt() :confirmPasswordDecrypt()
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.pop()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        validate() == false ? returnFunc() : changePasswordApi()
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
        case txtOldPassword:
            chngPswrdView.borderColor =  SSColor.appButton
        case txtNewPassword :
            newPswrdView.borderColor = SSColor.appButton
        case txtConfirmPassword :
            confirmPswrdView.borderColor = SSColor.appButton
        default:break
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case txtOldPassword:
            chngPswrdView.borderColor =  SSColor.appBlack
        case txtNewPassword :
            newPswrdView.borderColor = SSColor.appBlack
        case txtConfirmPassword :
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

extension ChangePasswordVC{
    func oldPasswordEncrypt(){
        txtOldPassword.isSecureTextEntry = false;cPImgView.image = UIImage(named: SSImageName.iconEyeShow)
    }
    func newPasswordEncrypt(){
        txtNewPassword.isSecureTextEntry = false;nextPasswordImgView.image = UIImage(named: SSImageName.iconEyeShow)
    }
    func confirmPasswordEncrypt(){
        txtConfirmPassword.isSecureTextEntry = false;confirmPasswordImgView.image = UIImage(named: SSImageName.iconEyeShow)
    }
    func oldPasswordDecrypt(){
        txtOldPassword.isSecureTextEntry = true;cPImgView.image = UIImage(named: SSImageName.iconEye)
    }
    func newPasswordDecrypt(){
        txtNewPassword.isSecureTextEntry = true;nextPasswordImgView.image = UIImage(named: SSImageName.iconEye)
    }
    func confirmPasswordDecrypt(){
        txtConfirmPassword.isSecureTextEntry = true;confirmPasswordImgView.image = UIImage(named: SSImageName.iconEye)
    }
}


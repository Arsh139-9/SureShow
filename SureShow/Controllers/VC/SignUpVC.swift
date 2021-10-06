//
//  SignUpVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 20/09/21.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift


class SignUpVC : BaseVC, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var txtFirstName: SSUsernameTextField!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var imgCnfrmPswrdIcon: UIImageView!
    @IBOutlet weak var imgPswrdIcon: UIImageView!
    @IBOutlet weak var txtConfirmPswrd: SSPasswordTextField!
    @IBOutlet weak var viewConfirmPswrd: UIView!
    @IBOutlet weak var txtPswrd: SSPasswordTextField!
    @IBOutlet weak var viewPswrd: UIView!
    @IBOutlet weak var txtEmail: SSEmailTextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var txtLastName: SSUsernameTextField!
    @IBOutlet weak var viewLastName: UIView!
    @IBOutlet weak var checkUncheckBtn: UIButton!
    let rest = RestManager()

    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    var unchecked = Bool()
    var iconClick = true
    
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
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPswrd.delegate = self
        txtConfirmPswrd.delegate = self
        
    }
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtFirstName.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter first name." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtLastName.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter last name." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtEmail.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter email address." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isValid(text: txtEmail.text!, for: RegularExpressions.email) == false {
            showAlertMessage(title: kAppName.localized(), message: "Please enter valid email address." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtPswrd.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter password." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
//        if ValidationManager.shared.isValid(text: txtPswrd.text!, for: RegularExpressions.password8AS) == false {
//            showAlertMessage(title: kAppName.localized(), message: "Please enter valid password. Password should contain at least 8 characters, with at least 1 letter and 1 special character." , okButton: "Ok", controller: self) {
//            }
//            
//            return false
//        }
        
        if ValidationManager.shared.isEmpty(text: txtConfirmPswrd.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter confirm password." , okButton: "Ok", controller: self) {
            }
            
            return false
        }
        
//        if ValidationManager.shared.isValid(text: txtPswrd.text!, for: RegularExpressions.password8AS) == false {
//            showAlertMessage(title: kAppName.localized(), message: "Please enter valid confirm password. Password should contain at least 8 characters, with at least 1 letter and 1 special character." , okButton: "Ok", controller: self) {
//            }
//            return false
//        }
        
        if ValidationManager.shared.isValidConfirm(password: txtPswrd.text!, confirmPassword: txtConfirmPswrd.text!) == false {
            showAlertMessage(title: kAppName.localized(), message: "New passwords and confirm password not match." , okButton: "Ok", controller: self) {
            }
            return false
        }
        
        return true
    }
    
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnConfrmPswrd(_ sender: Any) {
        if(iconClick == true) {
            txtConfirmPswrd.isSecureTextEntry = false
            imgCnfrmPswrdIcon.image = UIImage(named: SSImageName.iconEyeShow)
        } else {
            txtConfirmPswrd.isSecureTextEntry = true
            imgCnfrmPswrdIcon.image = UIImage(named: SSImageName.iconEye)
        }
        iconClick = !iconClick
    }
   
    open func signUpApi(){
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        AFWrapperClass.requestPostWithMultiFormData(kBASEURL + WSMethods.signUp, params: generatingParameters(), headers: nil) { response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            let message = response["message"] as? String ?? ""
            if let status = response["status"] as? Int {
                if status == 200{
                    showAlertMessage(title: kAppName.localized(), message: message , okButton: "OK", controller: self) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
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
        parameters["username"] = txtEmail.text  as AnyObject
        parameters["password"] = txtPswrd.text  as AnyObject
        parameters["first_name"] = txtFirstName.text  as AnyObject
        parameters["last_name"] = txtLastName.text  as AnyObject
        print(parameters)
        return parameters
    }
    @IBAction func btnSignup(_ sender: Any) {
        
        if validate() == false {
            return
        }
        
        else if checkUncheckBtn.currentImage?.pngData() == UIImage(named:"uncheck")?.pngData() {
            Alert.present(
                title: AppAlertTitle.appName.rawValue,
                message:AppSignInForgotSignUpAlertNessage.allowTermsConditionMessage,
                actions: .ok(handler: {
                }),
                from: self
            )
            
        }
        else{
            signUpApi()
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        self.pop()
    }
    
    @IBAction func btnPswrd(_ sender: Any) {
        if(iconClick == true) {
            txtPswrd.isSecureTextEntry = false
            imgPswrdIcon.image = UIImage(named: SSImageName.iconEyeShow)
        } else {
            txtPswrd.isSecureTextEntry = true
            imgPswrdIcon.image = UIImage(named: SSImageName.iconEye)
        }
        iconClick = !iconClick
    }
    
    @IBAction func btnCheckUncheck(_ sender: UIButton) {
        if sender.tag == 0{
            sender.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            sender.tag = 1
        }else{
            sender.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
            sender.tag = 0
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case txtFirstName:
            viewFirstName.borderColor = SSColor.appButton
        case txtLastName:
            viewLastName.borderColor = SSColor.appButton
        case txtEmail:
            viewEmail.borderColor = SSColor.appButton
        case txtPswrd:
            viewPswrd.borderColor = SSColor.appButton
        case txtConfirmPswrd:
            viewConfirmPswrd.borderColor = SSColor.appButton
        default:break
            
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case txtFirstName:
            viewFirstName.borderColor = SSColor.appBlack
        case txtLastName:
            viewLastName.borderColor = SSColor.appBlack
        case txtEmail:
            viewEmail.borderColor = SSColor.appBlack
        case txtPswrd:
            viewPswrd.borderColor = SSColor.appBlack
        case txtConfirmPswrd:
            viewConfirmPswrd.borderColor = SSColor.appBlack
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

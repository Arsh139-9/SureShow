//
//  AddQueueVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 20/09/21.
//

import UIKit
import Foundation
import Alamofire
import IQKeyboardManagerSwift

class AddQueueVC : BaseVC, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var viewHospitalName: UIView!
    @IBOutlet weak var txtHospitalName: SSHospitalTextField!
    @IBOutlet weak var txtDoctor: SSDoctorTextField!
    @IBOutlet weak var viewDoctor: UIView!
    @IBOutlet weak var viewDisease: UIView!
    @IBOutlet weak var txtDisease: SSDiseaseTextField!
    
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    
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
        
        txtDisease.delegate = self
        txtDoctor.delegate = self
        txtHospitalName.delegate = self
    }
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtHospitalName.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please select hospital name." , okButton: "Ok", controller: self) {
                
            }
            return false
        }
        if ValidationManager.shared.isEmpty(text: txtDoctor.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please select doctor name." , okButton: "Ok", controller: self) {
                
            }

           
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtDisease.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please select disease name." , okButton: "Ok", controller: self) {
                
            }

            return false
        }
        return true
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnSave(_ sender: Any) {
        validate()
    }
    @IBAction func btnBack(_ sender: Any) {
        self.pop()
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
//        switch textField {
//        case txtHospitalName:
//            txtHospitalName.borderColor = SSColor.appButton
//        case txtDoctor:
//            txtDoctor.borderColor =  SSColor.appButton
//        case txtDisease:
//            txtDisease.borderColor =  SSColor.appButton
//
//        default:break
//
//        }
        if textField == txtHospitalName {
            txtHospitalName.borderColor = SSColor.appButton
            
        } else if textField == txtDoctor {
            txtDoctor.borderColor = SSColor.appButton
        }else if textField == txtDisease{
            txtDisease.borderColor = SSColor.appButton
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        switch textField {
//
//        case txtHospitalName:
//            txtHospitalName.borderColor =  SSColor.appBlack
//        case txtDoctor:
//            txtDoctor.borderColor =  SSColor.appBlack
//        case txtDisease:
//            txtDisease.borderColor =  SSColor.appBlack
//
//        default:break
//        }
        
        if textField == txtHospitalName {
            txtHospitalName.borderColor = SSColor.appBlack
            
        } else if textField == txtDoctor {
            txtDoctor.borderColor = SSColor.appBlack
        }else if textField == txtDisease{
            txtDisease.borderColor = SSColor.appBlack
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

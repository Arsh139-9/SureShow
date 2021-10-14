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
    @IBOutlet weak var txtHospitalName: UITextField!
    @IBOutlet weak var txtDoctor: UITextField!
    @IBOutlet weak var viewDoctor: UIView!
    @IBOutlet weak var viewDisease: UIView!
    @IBOutlet weak var txtDisease: SSDiseaseTextField!
    
    @IBOutlet weak var txtProvider: UITextField!
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    var hospitalListArr = [HospitalListData<AnyHashable>]()
    var branchListArr = [BranchListData<AnyHashable>]()
    var providerListArr = [ProviderListData<AnyHashable>]()
    var diseaseListArr = [DiseaseListData<AnyHashable>]()

    var pvOptionArr = [String]()
    var hospitalId:Int?
    var branchId:Int?
    var globalPickerView = UIPickerView()
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
        txtProvider.delegate = self
        txtDisease.delegate = self
        globalPickerView.delegate = self
        globalPickerView.dataSource = self
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closePicker))
        let barButtonItem1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        
        let buttons = [barButtonItem1, barButtonItem]
        toolBar.setItems(buttons, animated: false)
        txtHospitalName.inputView = globalPickerView
        txtHospitalName.inputAccessoryView = toolBar
        txtDoctor.inputView = globalPickerView
        txtDoctor.inputAccessoryView = toolBar
        
        txtProvider.inputView = globalPickerView
        txtProvider.inputAccessoryView = toolBar
        
        txtDisease.inputView = globalPickerView
        txtDisease.inputAccessoryView = toolBar
//        pvOptionArr.removeAll()
//        for obj in hospitalListArr {
//            pvOptionArr.append(obj.clinic_name)
//        }
//        txtHospitalName.pvOptions = pvOptionArr
    }
  
    @objc func closePicker() {
        txtHospitalName.resignFirstResponder()
        txtDoctor.resignFirstResponder()
        txtProvider.resignFirstResponder()
        txtDisease.resignFirstResponder()

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
    open func getDiseaseListApi(){
        ModalResponse().getDiseaseListApi(){ response in
            print(response)
            let getDiseaseDataResp  = GetDiseaseData(dict:response as? [String : AnyHashable] ?? [:])
            let message = getDiseaseDataResp?.message ?? ""
            if let status = getDiseaseDataResp?.status{
                if status == 200{
                    self.diseaseListArr = getDiseaseDataResp?.diseaseListArray ?? []
                }
                else if status == 401{
                    removeAppDefaults(key:"AuthToken")
                    appDel.logOut()
                }
                else{
                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                }
            }
            
        } onFailure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
    }
    
    open func getBranchListApi(){
        for obj in hospitalListArr {
            if obj.clinic_name == txtHospitalName.text{
                hospitalId = obj.clinic_id
                break
            }
        }
        
        ModalResponse().getBranchListApi(clinicId:hospitalId ?? 0){ response in
            print(response)
            let getBranchDataResp  = GetBranchData(dict:response as? [String : AnyHashable] ?? [:])
            let message = getBranchDataResp?.message ?? ""
            if let status = getBranchDataResp?.status{
                if status == 200{
                    self.branchListArr = getBranchDataResp?.branchListArray ?? []
//                    self.pvOptionArr.removeAll()
//                    for obj in self.branchListArr {
//                        self.pvOptionArr.append(obj.branch_name)
//                    }
//                    self.txtDoctor.pvOptions = self.pvOptionArr
                }
                else if status == 401{
                    removeAppDefaults(key:"AuthToken")
                    appDel.logOut()
                }
                else{
                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                }
            }
            
        } onFailure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
    }
    open func getProviderListApi(){
        for obj in branchListArr {
            if obj.branch_name == txtDoctor.text{
                branchId = obj.id
                break
            }
        }
        
        ModalResponse().getProviderListApi(clinicId:hospitalId ?? 0, branchId: branchId ?? 0){ response in
            print(response)
            let getProviderDataResp  = GetProviderData(dict:response as? [String : AnyHashable] ?? [:])
            let message = getProviderDataResp?.message ?? ""
            if let status = getProviderDataResp?.status{
                if status == 200{
                    self.providerListArr = getProviderDataResp?.providerListArray ?? []
                    //                    self.pvOptionArr.removeAll()
                    //                    for obj in self.branchListArr {
                    //                        self.pvOptionArr.append(obj.branch_name)
                    //                    }
                    //                    self.txtDoctor.pvOptions = self.pvOptionArr
                }
                else if status == 401{
                    removeAppDefaults(key:"AuthToken")
                    appDel.logOut()
                }
                else{
                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                }
            }
            
        } onFailure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
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
        getDiseaseListApi()
    }
    
    //------------------------------------------------------
}
// MARK: UIPickerView DataSource
extension AddQueueVC:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtHospitalName.isFirstResponder == true{
            return hospitalListArr.count
        }else if txtDoctor.isFirstResponder == true{
            return branchListArr.count
        }else if txtProvider.isFirstResponder == true{
            return providerListArr.count
        }
        else if txtDisease.isFirstResponder{
            return diseaseListArr.count
        }
        else{
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtHospitalName.isFirstResponder {
            return hospitalListArr[row].clinic_name
        } else if txtDoctor.isFirstResponder {
            return branchListArr[row].branch_name
        } else if txtProvider.isFirstResponder {
            return providerListArr[row].name
        }  else if txtDisease.isFirstResponder{
            return diseaseListArr[row].disease_name
        }
        else{
            return "0"
        }
    }
}
// MARK: UIPickerView Delegates
extension AddQueueVC:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if txtHospitalName.isFirstResponder {
            txtHospitalName.text = hospitalListArr[row].clinic_name
            getBranchListApi()
//            currentStatusIndex = row
        } else if txtDoctor.isFirstResponder {
            txtDoctor.text = branchListArr[row].branch_name
            getProviderListApi()
//            currentTypeIndex = row
        } else if txtProvider.isFirstResponder {
            txtProvider.text = providerListArr[row].name
//            currentGearedIndex = row
        }
        else if txtDisease.isFirstResponder {
            txtDisease.text = diseaseListArr[row].disease_name
            //            currentGearedIndex = row
        }
    }
}

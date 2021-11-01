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
    @IBOutlet weak var viewProvider: UIView!
    @IBOutlet weak var txtDisease: SSDiseaseTextField!
    
    @IBOutlet weak var txtPatientName: SSPatientTextField!
    
    
    @IBOutlet weak var txtProvider: UITextField!
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    var patientListArr = [PatientListData<AnyHashable>]()
    var hospitalListArr = [HospitalListData<AnyHashable>]()
    var branchListArr = [BranchListData<AnyHashable>]()
    var providerListArr = [ProviderListData<AnyHashable>]()
    var diseaseListArr = [DiseaseListData<AnyHashable>]()

    var pvOptionArr = [String]()
    var hospitalId:Int?
    var branchId:Int?
    var hospitalSId:Int?
    var branchSId:Int?
    var patientSId:Int?
    var providerSId:Int?
    var diseaseSId:Int?

    var globalPickerView = UIPickerView()
    
    var rightUserView: UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let imgView = UIImageView(image: UIImage(named: SSImageName.iconDropDown))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
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
        
        txtDoctor.delegate = self
        txtHospitalName.delegate = self
        txtProvider.delegate = self
        txtDisease.delegate = self
        txtPatientName.delegate = self
        globalPickerView.delegate = self
        globalPickerView.dataSource = self
        

        let label = UILabel(frame: CGRect(x:0, y:0, width:300, height:19))
        label.text = kAppName
        label.center = CGPoint(x: view.frame.midX, y: view.frame.height)
        label.textAlignment = NSTextAlignment.center
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closePicker))
        let toolbarTitle = UIBarButtonItem(customView: label)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closePicker))
        
        
//        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closePicker))
//        let barButtonItem1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let barButtonItem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closePicker))
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        toolBar.setItems([cancelButton, toolbarTitle, doneButton], animated: false)

//        let buttons = [barButtonItem1, barButtonItem,barButtonItem2]
//        toolBar.setItems(buttons, animated: false)
        txtHospitalName.inputView = globalPickerView
        txtHospitalName.inputAccessoryView = toolBar
        txtDoctor.inputView = globalPickerView
        txtDoctor.inputAccessoryView = toolBar
        
        txtProvider.inputView = globalPickerView
        txtProvider.inputAccessoryView = toolBar
        
        txtDisease.inputView = globalPickerView
        txtDisease.inputAccessoryView = toolBar
        
        txtPatientName.inputView = globalPickerView
        txtPatientName.inputAccessoryView = toolBar
        
//        viewHospitalName .addSubview(rightUserView)
        txtHospitalName.setupRightImage(imageName:SSImageName.iconDropDown)
        txtDoctor.setupRightImage(imageName:SSImageName.iconDropDown)
        txtProvider.setupRightImage(imageName:SSImageName.iconDropDown)

//        txtHospitalName.rightView = rightUserView
//        txtHospitalName.rightViewMode = .always
        //        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        //        self.leftViewMode = .always
        
        pvOptionArr.removeAll()
        for obj in patientListArr {
            pvOptionArr.append("\(obj.last_name) \(obj.first_name)")
        }
        txtPatientName.pvOptions = pvOptionArr
    }
  
    @objc func closePicker() {
        txtHospitalName.resignFirstResponder()
        txtDoctor.resignFirstResponder()
        txtProvider.resignFirstResponder()
        txtDisease.resignFirstResponder()
        txtPatientName.resignFirstResponder()
    }
    func validate() -> Bool {
        if ValidationManager.shared.isEmpty(text: txtPatientName.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please select patient name." , okButton: "Ok", controller: self) {
                
            }
            return false
        }
        
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
    
    open func addQueueApi(){
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        AFWrapperClass.requestPostWithMultiFormData(kBASEURL + WSMethods.addGetQueueList, params: generatingParameters(), headers: headers) { response in
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
        parameters["clinic_id"] =  hospitalSId as AnyObject
        parameters["branch_id"] = branchSId  as AnyObject
        parameters["provider_id"] = providerSId  as AnyObject
        parameters["disease_id"] = diseaseSId  as AnyObject
        parameters["add_user_id"] = patientSId as AnyObject
      
//        parameters["usertype"] = "1" as AnyObject
        
        print(parameters)
        return parameters
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnSave(_ sender: Any) {
        if validate() == false {
            return
        }
        else{
            addQueueApi()
        }
        
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
        if textField == txtPatientName{
            txtDisease.borderColor = SSColor.appButton
        }
        else if textField == txtHospitalName {
            txtHospitalName.borderColor = SSColor.appButton
        } else if textField == txtDoctor {
            txtDoctor.borderColor = SSColor.appButton
        }else if textField == txtDisease{
            txtDisease.borderColor = SSColor.appButton
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtPatientName{
            txtDisease.borderColor = SSColor.appBlack
        }
        else if textField == txtHospitalName {
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
    
        if txtPatientName.isFirstResponder == true{
            return patientListArr.count
        }
       else if txtHospitalName.isFirstResponder == true{
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
        if txtPatientName.isFirstResponder == true{
            return "\(patientListArr[row].last_name) \(patientListArr[row].first_name)"
        }
        else if txtHospitalName.isFirstResponder {
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
        if txtPatientName.isFirstResponder == true{
            txtPatientName.text = "\(patientListArr[row].last_name) \(patientListArr[row].first_name)"
            patientSId = patientListArr[row].id
        }
       else if txtHospitalName.isFirstResponder {
            txtHospitalName.text = hospitalListArr[row].clinic_name
             hospitalSId = hospitalListArr[row].clinic_id

            getBranchListApi()
        } else if txtDoctor.isFirstResponder {
            txtDoctor.text = branchListArr[row].branch_name
            branchSId = branchListArr[row].id

            getProviderListApi()
        } else if txtProvider.isFirstResponder {
            txtProvider.text = providerListArr[row].name
            providerSId = providerListArr[row].id

        }
        else if txtDisease.isFirstResponder {
            txtDisease.text = diseaseListArr[row].disease_name
            diseaseSId = diseaseListArr[row].id

        }
    }
}
